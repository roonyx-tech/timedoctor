module TimeDoctor
  class Worker
    ENTRY = 'https://webapi.timedoctor.com/'.freeze

    attr_reader :payload

    def initialize(payload = {})
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
        refresh_tokens
        exchange(method, url, params, true)
      else
        raise UnknownError, response
      end
    end

    private

    def refresh_tokens
      response = @conn.get '/oauth/v2/token',
                           refresh_token: fetch_param(:refresh_token),
                           client_id:     fetch_param(:client_id),
                           client_secret: fetch_param(:client_secret),
                           grant_type:    :refresh_token,
                           _format:       :json

      case response.status
      when 200
        data = JSON.parse(response.body, symbolize_names: true)
        @payload[:access_token]  = data[:access_token]
        @payload[:refresh_token] = data[:refresh_token]

        utl = fetch_param(:update_tokens_lambda)
        utl.call(data, @payload) if utl
      else
        raise UnknownError, response
      end
    end

    def fetch_param(name)
      @payload[name] || Config[name]
    end
  end
end
