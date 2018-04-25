module TimeDoctor
  class Payrolls < Base
    def list(params)
      company_id = extract :company_id, params
      exchange :get, "/v1.1/companies/#{company_id}/payrolls", params
    end

    def update(params)
      company_id = extract :company_id, params
      payroll_id = extract :payroll_id, params
      exchange :put, "/v1.1/companies/#{company_id}/payrolls/#{payroll_id}", params
    end
  end
end
