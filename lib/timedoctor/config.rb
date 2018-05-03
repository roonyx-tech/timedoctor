module TimeDoctor
  module Config
    class << self
      def config
        @config ||= {}
      end

      def configure(conf = {})
        config.merge!(conf)
      end

      def [](index)
        config[index]
      end

      def []=(index, value)
        config[index] = value
      end
    end
  end
end
