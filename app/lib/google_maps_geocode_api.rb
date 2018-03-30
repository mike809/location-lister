class GoogleMapsGeocodeApi
  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api/'.freeze

  def initialize(location_params)
    @response_format = :json
    @options = {
      query: {
        address: location_params[:location_address],
        key: ENV['GOOGLE_API_KEY']
      }
    }
  end

  def formatted_addresses_and_locations
    @formatted_addresses ||= results.map do |result|
      {
        location_address: result.dig('formatted_address'),
        location_lonlat:
          "POINT (#{result.dig('geometry', 'location').values.join(' ')})"
      }
    end
  end

  private

  def results
    @results ||= geocoded_address.dig('results')
  end

  def geocoded_address
    @geocoded_address ||= self.class.get("/geocode/#{@response_format}", @options)
  end
end
