module TimeDoctor
  class Payload
    attr_reader :data

    def initialize(payload = {})
      @data = payload
    end

    def [](key)
      data[key] || Config[key]
    end

    def []=(key, value)
      data[key] = value
    end

    def call(name, *params)
      callback = self[name]
      return unless callback

      params = params << self
      callback.call(*params)
    end
  end
end
