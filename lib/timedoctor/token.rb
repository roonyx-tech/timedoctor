module TimeDoctor
  class Token
    ENTRY = 'https://webapi.timedoctor.com/oauth/v2/token'.freeze

    def initialize(config)
      @config = config
    end

    attr_reader :config

    def fetch
      response = Faraday.get ENTRY,
                             client_id:     config[:client_id],
                             client_secret: config[:client_secret],
                             code:          config[:code],
                             redirect_uri:  config[:redirect_uri],
                             grant_type:    :authorization_code,
                             _format:       :json

      data = JSON.parse(response.body, symbolize_names: true)

      case response.status
      when 200
        config[:access_token]  = data[:access_token]
        config[:refresh_token] = data[:refresh_token]
        config[:on_token_authorize].call(data, config)
      when 400
        config[:on_token_authorize_error].call(data, config)
      else
        raise UnknownError, response
      end
    end

    def refresh
      response = Faraday.get ENTRY,
                             refresh_token: config[:refresh_token],
                             client_id:     config[:client_id],
                             client_secret: config[:client_secret],
                             grant_type:    :refresh_token,
                             _format:       :json

      data = JSON.parse(response.body, symbolize_names: true)

      case response.status
      when 200
        config[:access_token]  = data[:access_token]
        config[:refresh_token] = data[:refresh_token]
        config[:on_token_refresh].call(data, config)
      when 400
        config[:on_token_refresh_error].call(data, config)
      else
        raise UnknownError, response
      end
    end
  end
end
