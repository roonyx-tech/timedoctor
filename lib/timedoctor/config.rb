require 'ostruct'

module TimeDoctor
  class Config
    class << self
      def configure(options = {}, &blk)
        @config = OpenStruct.new(options)

        config[:on_token_authorize] ||= lambda do |_data, _conf|
        end

        config[:on_token_authorize_error] ||= lambda do |data, _conf|
          raise UnauthorizedError, data
        end

        config[:on_token_refresh] ||= lambda do |_data, _conf|
        end

        config[:on_token_refresh_error] ||= lambda do |data, _conf|
          raise UnauthorizedError, data
        end

        instance_exec(config, &blk) if block_given?
        config
      end

      def config
        @config || configure
      end

      def [](key)
        config[key]
      end

      def []=(key, value)
        config[key] = value
      end

      def inspect
        config.to_h
      end
    end

    def initialize(options)
      @config = OpenStruct.new(options)
    end

    def config
      @config ||= OpenStruct.new
    end

    def [](key)
      config[key] || Config[key]
    end

    def []=(key, value)
      config[key] = value
    end

    def inspect
      {
        local: @config.to_h,
        global: Config.inspect
      }
    end
  end
end
