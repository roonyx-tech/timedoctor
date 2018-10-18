module TimeDoctor
  class Token
    ENTRY = 'https://webapi.timedoctor.com/oauth/v2/token'.freeze

    def initialize(config)
      @config = config
    end

    attr_reader :config

    def fetch
      response = get_token_data(
        code: config[:code],
        redirect_uri: config[:redirect_uri],
        grant_type: :authorization_code
      )
      process_response(
        response: response,
        callback_base_name: :on_token_authorize
      )
    end

    def refresh
      response = get_token_data(
        refresh_token: config[:refresh_token],
        grant_type: :refresh_token
      )
      process_response(
        response: response,
        callback_base_name: :on_token_refresh
      )
    end

    private

    def get_token_data(params)
      default_params = {
        client_id: config[:client_id],
        client_secret: config[:client_secret],
        _format: :json
      }
      Faraday.get(ENTRY, default_params.merge(params))
    end

    def process_response(response:, callback_base_name:)
      data = JSON.parse(response.body, symbolize_names: true)
      case response.status
      when 200
        update_tokens(data)
        invoke_callback(callback_base_name, data)
        data
      when 400
        invoke_callback("#{callback_base_name}_error", data)
        nil
      else
        raise UnknownError, response
      end
    end

    def update_tokens(data)
      config[:access_token] = data[:access_token]
      config[:refresh_token] = data[:refresh_token]
    end

    def invoke_callback(callback_name, data)
      callback = config[callback_name]
      return unless callback.respond_to?(:call)
      callback.call(data, config)
    end
  end
end
