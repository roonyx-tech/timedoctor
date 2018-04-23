require 'faraday'
require 'json'

module Timedoctor
  class Client
    ENTRY = 'https://webapi.timedoctor.com/'.freeze

    def initialize(token)
      @token = token
      @conn = Faraday.new(url: ENTRY)
    end

    def companies
      exchange :get, '/v1.1/companies'
    end

    def create_company(params)
      exchange :post, '/v1.1/companies', params
    end

    def invite_user(params)
      exchange :post, '/v1.1/companies/invites', params
    end

    def absent_and_late(params)
      company_id = extract :company_id, params
      exchange :get, "/v1.1/companies/#{company_id}/absent-and-late", params
    end

    def edit_absent_and_late(params)
      company_id = extract :company_id, params
      exchange :put, "/v1.1/companies/#{company_id}/absent-and-late", params
    end

    def poor_time(params)
      company_id = extract :company_id, params
      exchange :get, "/v1.1/companies/#{company_id}/poortime", params
    end

    def worklogs(params)
      company_id = extract :company_id, params
      exchange :get, "/v1.1/companies/#{company_id}/worklogs", params
    end

    def web_and_app(params)
      company_id = extract :company_id, params
      exchange :get, "/v1.1/companies/#{company_id}/webandapp", params
    end

    private

    def extract(ext, params)
      extracted = params.delete(ext)
      raise ArgumentError, "'#{ext}' not found in params" unless extracted
      extracted
    end

    def exchange(method, url, params = {})
      params[:access_token] = @token
      params[:_format] = :json

      response = @conn.send method, url, params

      case response.status
      when 200
        JSON.parse response.body
      when 401
        raise 'NOT AUTH'
      else
        raise "#{response.status} FUUU"
      end
    end
  end
end
