module TimeDoctor
  module Core
    class Fake < Base
      def success
        exchange :post, '/success'
      end

      def expired_token
        exchange :post, '/expired_token'
      end

      def unknown_error
        exchange :post, '/unknown_error'
      end
    end
  end
end
