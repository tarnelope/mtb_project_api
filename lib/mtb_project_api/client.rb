require 'faraday'
require 'oj'

module MtbProjectApi
  class Client
    API_ENDPOINT = 'https://www.mtbproject.com/data/'.freeze

    def initialize(email, private_key)
      @email = email
      @private_key = private_key
    end

    # Returns trails for a given query.
    #
    # Required Arguments:
    # key - Your private key
    # lat - Latitude for a given area
    # lon - Longitude for a given area
    #
    # Optional Arguments:
    # maxDistance - Max distance, in miles, from lat, lon. Default: 30. Max: 200.
    # maxResults - Max number of trails to return. Default: 10. Max: 500.
    # sort - Values can be 'quality', 'distance'. Default: quality.
    # minLength - Min trail length, in miles. Default: 0 (no minimum).
    # minStars - Min star rating, 0-4. Default: 0.
    def get_local_trails(params = {})
      allowed_keys = [:lat, :lon, :maxDistance, :maxResults, :sort, :minLength, :minStars]
      request_params = params.select { |k| allowed_keys.include?(k) }.merge(key: @private_key)

      request(
        http_method: :get,
        endpoint: "get-trails",
        params: request_params
      )
    end

    # Returns trails for given IDs.
    #
    # Required Arguments:
    # ids - one or array of trail IDs
    def get_trails_by_id(params = {})
      request_by_ids("get-trails-by-id", params)
    end

    # Returns conditions for a given trail.
    #
    # Required Arguments:
    # ids - one or array of trail IDs
    def get_conditions(params = {})
      request_by_ids("get-conditions", params)
    end

    # Returns up to 200 of the user's to-dos.
    #
    # Optional Arguments:
    # startPos - The starting index of the list to return. Defaults to 0.
    def get_to_dos(params = {})
      request_params = params.merge({
        email: @email,
        key: @private_key
      })

      request(
          http_method: :get,
          endpoint: "get-to-dos",
          params: request_params
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

    def request_by_ids(endpoint, params)
      request_params = request_by_ids_params(params)

      request(
        http_method: :get,
        endpoint: endpoint,
        params: request_params
      )
    end

    def request_by_ids_params(params)
      ids = Array(params[:ids]).join(',')

      {
        ids: ids,
        key: @private_key
      }
    end
  end
end
