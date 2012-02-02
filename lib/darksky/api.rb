require 'typhoeus'
require 'json'

module Darksky
  class API
    DARKSKY_API_URL = 'http://api.darkskyapp.com/v1'

    def initialize(api_key)
      @api_key = api_key
    end

    def forecast(latitude, longitude)
      response = Typhoeus::Request.get("#{DARKSKY_API_URL}/forecast/#{@api_key}/#{latitude},#{longitude}")
      JSON.parse(response.body) if response.code == 200
    end

    def precipitation(latitude_longitude_times)
      return if latitude_longitude_times.size % 3 != 0
      response = Typhoeus::Request.get("#{DARKSKY_API_URL}/precipitation/#{@api_key}/#{latitude_longitude_times.join(',')}")
    end
  end
end