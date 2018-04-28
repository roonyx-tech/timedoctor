module TimeDoctor
  module Core
    class WebAndApp < Base
      def list(company_id:, **params)
        exchange :get, "/v1.1/companies/#{company_id}/webandapp", params
      end
    end
  end
end
