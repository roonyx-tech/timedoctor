require 'faraday'

module TimeDoctor
  module Core
    class Base
      def initialize(worker)
        @worker = worker
      end

      private

      def exchange(method, url, params = {})
        @worker.exchange(method, url, params)
      end
    end
  end
end
