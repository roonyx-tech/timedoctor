module TimeDoctor
  module Core
    class Projects < Base
      def list(params)
        company_id, user_id = extract params, :company_id, :user_id
        exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}/projects", params
      end

      def create(params)
        company_id, user_id = extract params, :company_id, :user_id
        exchange :post, "/v1.1/companies/#{company_id}/users/#{user_id}/projects", params
      end

      def delete(params)
        company_id, user_id, project_id = extract params, :company_id, :user_id, :project_id
        exchange :delete,
                 "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}",
                 params
      end

      def info(params)
        company_id, user_id, project_id = extract params, :company_id, :user_id, :project_id
        exchange :get,
                 "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}",
                 params
      end

      def assign_user(params)
        company_id, user_id, project_id = extract params, :company_id, :user_id, :project_id
        exchange :put,
                 "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}",
                 params
      end

      def unassign_user(params)
        company_id, user_id, project_id = extract params, :company_id, :user_id, :project_id
        exchange :delete,
                 "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}/users",
                 params
      end
    end
  end
end
