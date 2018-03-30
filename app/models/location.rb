class Location < ApplicationRecord
  delegate :coordinates, to: :location_lonlat

  def longitude
    coordinates.first
  end

  def latitude
    coordinates.last
  end
end
