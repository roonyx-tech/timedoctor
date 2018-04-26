module TimeDoctor
  class AbsentAndLate < Base
    def list(params)
      company_id = extract params, :company_id
      exchange :get, "/v1.1/companies/#{company_id}/absent-and-late", params
    end

    def update(params)
      company_id = extract params, :company_id
      exchange :put, "/v1.1/companies/#{company_id}/absent-and-late", params
    end
  end
end
