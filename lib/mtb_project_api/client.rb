require 'faraday'
require 'oj'
require 'geocoder'

module MtbProjectApi
  class Client
    API_ENDPOINT = 'https://www.mtbproject.com/data/'.freeze

    def initialize(email, private_key)
      @email = email
      @private_key = private_key
    end

    def get_local_trails(params = {})
      allowed_keys = [:lat, :lon, :maxDistance, :maxResults, :sort, :minLength, :minStars]
      request_params = params.select { |k| allowed_keys.include?(k) }.merge(key: @private_key)

      request(
        http_method: :get,
        endpoint: "get-trails",
        params: request_params
      )
    end

    def get_trails_by_id(params = {})
      request_by_ids("get-trails-by-id", params)
    end

    def get_conditions(params = {})
      request_by_ids("get-conditions", params)
    end

    def get_to_dos
      request_params = {
        email: @email,
        key: @private_key
      }

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
