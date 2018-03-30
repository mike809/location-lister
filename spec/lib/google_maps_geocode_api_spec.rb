require 'spec_helper'

describe GoogleMapsGeocodeApi do
  let(:location_address) { '650 Pennsylvania ave' }
  subject { described_class.new({ location_address: location_address }) }

  let(:ambiguous_response) do
    {
      results: [
        {
          address_components: [
            {
              long_name: '1885',
              short_name: '1885',
              types: ['street']
            },
            {
              long_name: 'Amsterdam Avenue',
              short_name: 'Amsterdam Av',
              types: ['route']
            }
          ],
          formatted_address: '1885 Amsterdam Ave, Manhattan NY, 10032',
          geometry: {
            location: { longitude: 100, latitude: -100 },
            location_type: 'ROOFTOP'
          },
          types: ['street_address']
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
      .with(query: { address: location_address, key: ENV['GOOGLE_API_KEY'] })
      .to_return(
        body: response.to_json,
        headers: {'Content-Type' => 'application/json' }
      )
  end

  describe '.formatted_addresses_and_locations' do
    context 'when we get a full response' do
      let(:response) { ambiguous_response }

      it 'extracts and transform only the relevant information' do
        expect(subject.formatted_addresses_and_locations).to eq [
          {
            location_address: '1885 Amsterdam Ave, Manhattan NY, 10032',
            location_lonlat: 'POINT (100 -100)'
          },
          {
            location_address: '1885 Amsterdam Ave, Charlote NC, 45698',
            location_lonlat: 'POINT (150 -100)'
          }
        ]
      end
    end

    context 'when the location address is ambiguousa dn has 2 posibilities' do
      let(:response) { ambiguous_response }

      it 'returns 2 formatted address hashes' do
        expect(subject.formatted_addresses_and_locations.count).to eq(2)
      end
    end

    context 'when the location address is not ambiguous' do
      let(:response) do
        {
          results: [
            {
              formatted_address: '1885 Amsterdam Ave, Manhattan NY, 10032',
              geometry: { location: { longitude: 100, latitude: -100 } }
            }
          ]
        }
      end
      it 'returns 1 formatted address hash' do
        expect(subject.formatted_addresses_and_locations.count).to eq(1)
      end
    end
  end
end