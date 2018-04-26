module TimeDoctor
  class Tasks < Base
    def list(params)
      company_id, user_id = extract params, :company_id, :user_id
      exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks", params
    end

    def create(params)
      company_id, user_id = extract params, :company_id, :user_id
      exchange :post, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks", params
    end

    def info(params)
      company_id, user_id, task_id = extract params, :company_id, :user_id, :task_id
      exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks/#{task_id}", params
    end

    def update(params)
      company_id, user_id, task_id = extract params, :company_id, :user_id, :task_id
      exchange :put, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks/#{task_id}", params
    end
  end
end
