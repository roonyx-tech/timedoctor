module TimeDoctor
  class Worker
    ENTRY = 'https://webapi.timedoctor.com/'.freeze

    attr_reader :payload

    def initialize(payload)
      raise EmptyAccessToken unless payload[:access_token]

      @payload = payload
      @conn    = Faraday.new(url: ENTRY)
    end

    def exchange(method, url, params = {}, badly = false)
      params[:access_token] = @payload[:access_token]
      params[:_format]      = :json

      response = @conn.public_send method, url, params

      case response.status
      when 200
        JSON.parse(response.body, symbolize_names: true)
      when 401
        raise UnauthorizedError, response if badly
        Token.refresh(@payload)
        exchange(method, url, params, true)
      else
        raise UnknownError, response
      end
    end
  end
end
