module TimeDoctor
  class Companies < Base
    def list
      exchange :get, '/v1.1/companies'
    end

    def create(params)
      exchange :post, '/v1.1/companies', params
    end

    def invite_user(params)
      exchange :post, '/v1.1/companies/invites', params
    end
  end
end
