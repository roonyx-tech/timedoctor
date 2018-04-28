module TimeDoctor
  module Core
    class AbsentAndLate < Base
      def list(company_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/absent-and-late", params
      end

      def update(company_id:, **params)
        exchange :put, "/v1.1/companies/#{company_id}/absent-and-late", params
      end
    end
  end
end
