require 'rails_helper'

RSpec.feature "Locations creation", :type => :feature do
  let(:location_address) { '1885 amsterdam av' }
  let(:single_result_response) do
    {
      results: [
        {
          formatted_address: '1885 Amsterdam Ave, Manhattan NY, 10032',
          geometry: { location: { longitude: 100, latitude: -100 } }
        }
      ]
    }
  end

  before do
    stub_request(:get, 'https://maps.googleapis.com/maps/api/geocode/json')
      .with(query: { address: location_address, key: ENV['GOOGLE_API_KEY'] })
      .to_return(
        body: response.to_json,
        headers: {'Content-Type' => 'application/json' }
      )
  end

  context 'when we have a single result' do
    let(:response) { single_result_response }

    scenario 'Visitor saves an unambiguous location' do
      visit '/'

      fill_in 'Location address', with: location_address
      click_button 'Save location'

      expect(page).not_to have_text('Multiple results match that address, which one woudl you like to save?')
      expect(page).to have_text('1885 Amsterdam Ave, Manhattan NY, 10032')
    end
  end

  context 'when we have a multiple results' do
    let(:corrected_address) { '1885 Amsterdam Ave, Manhattan NY, 10032' }
    let(:response) do
      {
        results: [
          {
            formatted_address: corrected_address,
            geometry: { location: { longitude: 100, latitude: -100 } }
          },
          {
            formatted_address: '1885 Amsterdam Ave, Charlote NC, 45698',
            geometry: { location: { longitude: 150, latitude: -100 } }
          }
        ]
      }
    end

    before do
      stub_request(:get, 'https://maps.googleapis.com/maps/api/geocode/json')
        .with(query: { address: corrected_address, key: ENV['GOOGLE_API_KEY'] })
        .to_return(
          body: single_result_response.to_json,
          headers: {'Content-Type' => 'application/json' }
        )
    end

    scenario 'Visitor saves an unambiguous location' do
      visit '/'

      fill_in 'Location address', with: location_address
      click_button 'Save location'

      expect(page).to have_text('Multiple results match that address, which one woudl you like to save?')
      expect { first('tr input[type="submit"]').click }.to change(Location, :count).from(0).to(1)
      expect(page).to have_text('1885 Amsterdam Ave, Manhattan NY, 10032')
    end
  end
end
