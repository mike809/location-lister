require 'rails_helper'

RSpec.describe Location, type: :model do
  subject { FactoryBot.create(:location, location_lonlat: 'POINT(-100 50)') }

  describe '#longitude' do
    it 'returns the longitude from the lonlat point' do
      expect(subject.longitude).to eq -100
    end
  end

  describe '#longitude' do
    it 'returns the longitude from the lonlat point' do
      expect(subject.latitude).to eq 50
    end
  end
end
