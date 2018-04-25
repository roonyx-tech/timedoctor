module TimeDoctor
  class Poortime < Base
    def list(params)
      company_id = extract :company_id, params
      exchange :get, "/v1.1/companies/#{company_id}/poortime", params
    end
  end
end
