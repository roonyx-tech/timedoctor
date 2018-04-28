module TimeDoctor
  module Core
    class Users < Base
      def list(company_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/users", params
      end

      def info(company_id:, user_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}", params
      end
    end
  end
end
