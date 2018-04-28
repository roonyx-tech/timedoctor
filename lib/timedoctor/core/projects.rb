module TimeDoctor
  module Core
    class Projects < Base
      def list(company_id:, user_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}/projects", params
      end

      def create(company_id:, user_id:, **params)
        exchange :post, "/v1.1/companies/#{company_id}/users/#{user_id}/projects", params
      end

      def delete(company_id:, user_id:, project_id:, **params)
        exchange :delete,
                 "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}",
                 params
      end

      def info(company_id:, user_id:, project_id:, **params)
        exchange :get,
                 "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}",
                 params
      end

      def assign_user(company_id:, user_id:, project_id:, **params)
        exchange :put,
                 "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}",
                 params
      end

      def unassign_user(company_id:, user_id:, project_id:, **params)
        exchange :delete,
                 "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}/users",
                 params
      end
    end
  end
end
