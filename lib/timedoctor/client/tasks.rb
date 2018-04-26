module TimeDoctor
  class Tasks < Base
    def list(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params

      exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks", params
    end

    def create(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params

      exchange :post, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks", params
    end

    def info(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params
      task_id = extract :task_id, params

      exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks/#{task_id}", params
    end

    def update(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params
      task_id = extract :task_id, params

      exchange :put, "/v1.1/companies/#{company_id}/users/#{user_id}/tasks/#{task_id}", params
    end
  end
end
