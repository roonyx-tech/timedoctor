module TimeDoctor
  class Auth
    def initialize(config)
      @config = Config.new(config)
    end

    attr_reader :config

    def fetch_token
      TimeDoctor::Token.new(config).fetch
    end
  end
end
