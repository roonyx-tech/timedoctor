module TimeDoctor
  class WebAndApp < Base
    def list(params)
      company_id = extract :company_id, params
      exchange :get, "/v1.1/companies/#{company_id}/webandapp", params
    end
  end
end
