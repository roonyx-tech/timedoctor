module TimeDoctor
  module Core
    class Payrolls < Base
      def list(company_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/payrolls", params
      end

      def update(company_id:, payroll_id:, **params)
        exchange :put, "/v1.1/companies/#{company_id}/payrolls/#{payroll_id}", params
      end
    end
  end
end
