require 'ostruct'

module TimeDoctor
  class Config
    class << self
      def configure(options = {}, &blk)
        @config = OpenStruct.new(options)
        instance_exec(@config, &blk) if block_given?
      end

      def config
        @config ||= OpenStruct.new
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
  end
end
