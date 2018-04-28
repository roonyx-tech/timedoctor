require 'faraday'

module TimeDoctor
  class Token
    class << self
      def refresh(refresh_token:, client_id: nil, client_secret: nil)
        response = Faraday.get 'https://webapi.timedoctor.com/oauth/v2/token',
                               client_id:  client_id,
                               client_secret: client_secret,
                               refresh_token: refresh_token,
                               grant_type: :refresh_token

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
