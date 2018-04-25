module TimeDoctor
  class AbsentAndLate < Base
    def list(params)
      company_id = extract :company_id, params
      exchange :get, "/v1.1/companies/#{company_id}/absent-and-late", params
    end

    def update(params)
      company_id = extract :company_id, params
      exchange :put, "/v1.1/companies/#{company_id}/absent-and-late", params
    end
  end
end
