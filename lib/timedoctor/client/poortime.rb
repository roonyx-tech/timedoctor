module TimeDoctor
  module Core
    class Poortime < Base
      def list(params)
        company_id = extract params, :company_id
        exchange :get, "/v1.1/companies/#{company_id}/poortime", params
      end
    end
  end
end
