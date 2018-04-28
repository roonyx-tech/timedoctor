module TimeDoctor
  module Core
    class Worklogs < Base
      def list(company_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/worklogs", params
      end
    end
  end
end
