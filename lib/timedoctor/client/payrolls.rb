module TimeDoctor
  module Core
    class Payrolls < Base
      def list(params)
        company_id = extract params, :company_id
        exchange :get, "/v1.1/companies/#{company_id}/payrolls", params
      end

      def update(params)
        company_id, payroll_id = extract params, :company_id, :payroll_id
        exchange :put, "/v1.1/companies/#{company_id}/payrolls/#{payroll_id}", params
      end
    end
  end  
end
