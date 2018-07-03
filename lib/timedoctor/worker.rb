module TimeDoctor
  class Worker
    ENTRY = 'https://webapi.timedoctor.com/'.freeze

    attr_reader :config, :conn

    def initialize(config)
      @config = config
      @conn   = Faraday.new(url: ENTRY)
    end

    def exchange(method, url, params = {})
      raise EmptyAccessToken unless config[:access_token]

      params[:access_token] = config[:access_token]
      params[:_format]      = :json

      response = conn.public_send method, url, params

      case response.status
      when 200
        JSON.parse(response.body, symbolize_names: true)
      when 401
        Token.new(config).refresh
        exchange(method, url, params)
      else
        raise UnknownError, response
      end
    end
  end
end
