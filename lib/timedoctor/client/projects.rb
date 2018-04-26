module TimeDoctor
  class Projects < Base
    def list(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params

      exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}/projects", params
    end

    def create(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params

      exchange :post, "/v1.1/companies/#{company_id}/users/#{user_id}/projects", params
    end

    def delete(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params
      project_id = extract :project_id, params

      exchange :delete,
               "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}",
               params
    end

    def info(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params
      project_id = extract :project_id, params

      exchange :get,
               "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}",
               params
    end

    def assign_user(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params
      project_id = extract :project_id, params

      exchange :put,
               "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}",
               params
    end

    def unassign_user(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params
      project_id = extract :project_id, params

      exchange :delete,
               "/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}/users",
               params
    end
  end
end
