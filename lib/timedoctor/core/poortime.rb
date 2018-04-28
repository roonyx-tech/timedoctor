module TimeDoctor
  module Core
    class Poortime < Base
      def list(company_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/poortime", params
      end
    end
  end
end
