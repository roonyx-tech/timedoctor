module TimeDoctor
  module Core
    class Users < Base
      def list(params)
        company_id = extract params, :company_id
        exchange :get, "/v1.1/companies/#{company_id}/users", params
      end

      def info(params)
        company_id, user_id = extract params, :company_id, :user_id
        exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}", params
      end
    end
  end
end
