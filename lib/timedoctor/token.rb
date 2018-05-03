require 'faraday'

module TimeDoctor
  class Token
    class << self
      def refresh(refresh_token:,
                  client_id: Config[:client_id],
                  client_secret: Config[:client_secret])

        response = Faraday.get 'https://webapi.timedoctor.com/oauth/v2/token',
                               client_id:  client_id,
                               client_secret: client_secret,
                               refresh_token: refresh_token,
                               grant_type: :refresh_token,
                               _format: :json

        case response.status
        when 200
          JSON.parse(response.body, symbolize_names: true)
        when 400
          raise InvalidRefreshTokenError, response
        else
          raise UnknownError, response
        end
      end
    end
  end
end
