module TimeDoctor
  class Token
    class << self
      ENTRY = 'https://webapi.timedoctor.com/oauth/v2/token'.freeze

      def authorize(payload)
        payload = Payload.new(payload)

        response = Faraday.get ENTRY,
                               client_id:     payload[:client_id],
                               client_secret: payload[:client_secret],
                               code:          payload[:code],
                               redirect_uri:  payload[:redirect_uri],
                               grant_type:    :authorization_code,
                               _format:       :json

        data = body(response)
        payload.call(:on_token_authorize, data)
        data
      end

      def refresh(payload)
        response = Faraday.get ENTRY,
                               refresh_token: payload[:refresh_token],
                               client_id:     payload[:client_id],
                               client_secret: payload[:client_secret],
                               grant_type:    :refresh_token,
                               _format:       :json

        data = body(response)
        payload[:access_token]  = data[:access_token]
        payload[:refresh_token] = data[:refresh_token]
        payload.call(:on_token_refresh, data)
        data
      end

      private

      def body(response)
        raise UnknownError, response if response.status != 200
        JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
