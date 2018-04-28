module TimeDoctor
  module Core
    class WebAndApp < Base
      def list(params)
        company_id = extract params, :company_id
        exchange :get, "/v1.1/companies/#{company_id}/webandapp", params
      end
    end
  end
end
