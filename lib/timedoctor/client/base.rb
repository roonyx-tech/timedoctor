require 'faraday'
require 'json'

module TimeDoctor
  class Base
    ENTRY = 'https://webapi.timedoctor.com/'.freeze

    def initialize(token)
      @token = token
      @conn = Faraday.new(url: ENTRY)
    end

    private

    def extract(ext, params)
      params.delete(ext) { raise ArgumentError, "'#{ext}' not found in params" }
    end

    def exchange(method, url, params = {})
      params[:access_token] = @token
      params[:_format]      = :json

      response = @conn.send method, url, params

      case response.status
      when 200
        JSON.parse(response.body, symbolize_names: true)
      when 401
        raise UnauthorizedError, response
      else
        raise UnknownError, response
      end
    end
  end
end
