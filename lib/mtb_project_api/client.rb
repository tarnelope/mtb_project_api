require 'faraday'
require 'oj'

module MtbProjectApi
  class Client
    API_ENDPOINT = 'https://www.mtbproject.com/data/'.freeze

    def initialize(email, private_key)
      @email = email
      @private_key = private_key
    end

    # Required Arguments:
    # key - Your private key
    # lat - Latitude for a given area
    # lon - Longitude for a given area

    # Optional Arguments:
    # maxDistance - Max distance, in miles, from lat, lon. Default: 30. Max: 200.
    # maxResults - Max number of trails to return. Default: 10. Max: 500.
    # sort - Values can be 'quality', 'distance'. Default: quality.
    # minLength - Min trail length, in miles. Default: 0 (no minimum).
    # minStars - Min star rating, 0-4. Default: 0.

    # Example:
    # https://www.mtbproject.com/data/get-trails?lat=40.0274&lon=-105.2519&maxDistance=10
    def get_local_trails(params)
    end

    def get_trails_by_id(ids)
    end

    def get_conditions(id)
    end

    def get_to_dos
      request(
          http_method: :get,
          endpoint: "get-to-dos?email=#{@email}&key=#{private_key}"
        )
    end

    private

    def client
      @_client ||= Faraday.new(API_ENDPOINT) do |client|
        client.request :url_encoded
        client.adapter Faraday.default_adapter
      end
    end

    def request(http_method:, endpoint:, params: {})
      response = client.public_send(http_method, endpoint, params)
      Oj.load(response.body)
    end
  end
end
