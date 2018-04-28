module TimeDoctor
  module Core
    class Companies < Base
      def list(**params)
        exchange :get, '/v1.1/companies', params
      end

      def create(**params)
        exchange :post, '/v1.1/companies', params
      end

      def invite_user(**params)
        exchange :post, '/v1.1/companies/invites', params
      end
    end
  end
end
