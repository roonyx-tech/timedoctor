module TimeDoctor
  module Core
    class Tasks < Base
      def list(company_id:, user_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks", params
      end

      def create(company_id:, user_id:, **params)
        exchange :post, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks", params
      end

      def info(company_id:, user_id:, task_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks/#{task_id}", params
      end

      def update(company_id:, user_id:, task_id:, **params)
        exchange :put, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks/#{task_id}", params
      end
    end
  end
end
