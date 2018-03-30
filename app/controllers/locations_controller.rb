class LocationsController < ApplicationController
  before_action :load_locations

  def create
    geocode_api = GoogleMapsGeocodeApi.new(location_params)
    geocoded_locations = geocode_api.formatted_addresses_and_locations

    if geocoded_locations.count == 1
      Location.create(geocoded_locations.first)
    else
      @results = geocoded_locations.map do |location_params|
        Location.new(location_params)
      end
    end

    render :index
  end

  private

  def load_locations
    @location = Location.new
    @locations = Location.all
  end

  def location_params
    params.fetch(:location, {}).permit(:location_address)
  end
end
