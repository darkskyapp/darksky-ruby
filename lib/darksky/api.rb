require 'typhoeus'
require 'json'

module Darksky
  class API
    DARKSKY_API_URL = 'https://api.darkskyapp.com/v1'
    DEFAULT_OPTIONS = {
    }

    # Create a new instance of the Darksky::API using your API key.
    #
    # @param api_key [String] Dark Sky API key.
    def initialize(api_key)
      @api_key = api_key
    end

    # Returns a forecast for the next hour at a given location.
    #
    # @param latitude [String] Latitude in decimal degrees.
    # @param longitude [String] Longitude in decimal degrees.
    # @param option [Hash] (Optional) Options to be passed to the Typhoeus::Request
    def forecast(latitude, longitude, options = {})
      response = Typhoeus::Request.get("#{DARKSKY_API_URL}/forecast/#{@api_key}/#{latitude},#{longitude}", DEFAULT_OPTIONS.dup.merge(options))
      JSON.parse(response.body) if response.code == 200
    end

    # Returns a brief forecast for the next hour at a given location.
    #
    # @param latitude [String] Latitude in decimal degrees.
    # @param longitude [String] Longitude in decimal degrees.
    # @param option [Hash] (Optional) Options to be passed to the Typhoeus::Request
    def brief_forecast(latitude, longitude, options = {})
      response = Typhoeus::Request.get("#{DARKSKY_API_URL}/brief_forecast/#{@api_key}/#{latitude},#{longitude}", DEFAULT_OPTIONS.dup.merge(options))
      JSON.parse(response.body) if response.code == 200
    end

    # Returns forecasts for a collection of arbitrary points.
    #
    # @param latitudes_longitudes_times [Array] Triplets of latitude, longitude and time. Example: ['42.7','-73.6',1325607100,'42.0','-73.0',1325607791]
    # @param option [Hash] (Optional) Options to be passed to the Typhoeus::Request
    def precipitation(latitudes_longitudes_times, options = {})
      return if latitudes_longitudes_times.size % 3 != 0
      params = []
      latitudes_longitudes_times.each_slice(3) do |data|
        params << data.join(',')
      end
      response = Typhoeus::Request.get("#{DARKSKY_API_URL}/precipitation/#{@api_key}/#{params.join(';')}", DEFAULT_OPTIONS.dup.merge(options))
      JSON.parse(response.body) if response.code == 200
    end

    # Returns a list of interesting storms happening right now.
    #
    # @param option [Hash] (Optional) Options to be passed to the Typhoeus::Request
    def interesting(options = {})
      response = Typhoeus::Request.get("#{DARKSKY_API_URL}/interesting/#{@api_key}", DEFAULT_OPTIONS.dup.merge(options))
      JSON.parse(response.body) if response.code == 200
    end

    # Create a notification.
    #
    # @param latitude [String] Latitude to check for the notification in decimal degrees.
    # @param longitude [String] Longitude to check for the notification in decimal degrees.
    # @param callback_uri [String] HTTP(S) URI to request when a notification fires.
    # @param threshold [int, 15] a dBZ value between 2 and 75 (inclusive).
    # @param options [Hash] Options to be passed to the Typhoeus::Request.
    def create_notification(latitude, longitude, callback_uri, threshold = 15, options = {})
      post_data = {
        :params => {
          :lat => latitude,
          :long => longitude,
          :callback => callback_uri,
          :threshold => threshold
        }
      }

      post_data = post_data.merge(DEFAULT_OPTIONS.dup.merge(options))

      response = Typhoeus::Request.post("#{DARKSKY_API_URL}/create_notification/#{@api_key}", post_data)
      JSON.parse(response.body) if response.code == 200
    end

    # Retrieve a notification.
    #
    # @param notification_id [String] Notification ID.
    # @param options [Hash] Options to be passed to the Typhoeus::Request.
    def retrieve_notification(notification_id, options = {})
      response = Typhoeus::Request.get("#{DARKSKY_API_URL}/notification/#{@api_key}/#{notification_id}", DEFAULT_OPTIONS.dup.merge(options))
      JSON.parse(response.body) if response.code == 200
    end

    # Update a notification.
    #
    # @param notification_id [String] Notification ID.
    # @param notification_parameters [Hash] Updated notification parameters.
    # @param options [Hash] Options to be passed to the Typhoeus::Request.
    def update_notification(notification_id, notification_parameters = {}, options = {})
      post_data = {
        :params => notification_parameters
      }

      post_data[:params][:id] = notification_id
      post_data = post_data.merge(DEFAULT_OPTIONS.dup.merge(options))

      response = Typhoeus::Request.post("#{DARKSKY_API_URL}/update_notification/#{@api_key}", post_data)
      JSON.parse(response.body) if response.code == 200
    end
  end
end