module TimeDoctor
  class Users < Base
    def list(params)
      company_id = extract :company_id, params
      exchange :get, "/v1.1/companies/#{company_id}/users", params
    end

    def info(params)
      company_id = extract :company_id, params
      user_id = extract :user_id, params
      exchange :get, "/v1.1/companies/#{company_id}/users/#{user_id}", params
    end
  end
end
