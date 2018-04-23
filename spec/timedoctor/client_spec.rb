RSpec.describe Timedoctor::Client do
  let(:entry) { 'https://webapi.timedoctor.com' }
  let(:token) { 'TOKEN' }
  let(:company_id) { 123 }
  let(:client) { Timedoctor::Client.new token }
  let(:response) do
    {
      status: 200,
      body: JSON.generate({})
    }
  end

  context 'absent and late' do
    let!(:get_stub) do
      stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/absent-and-late" \
                         "?_format=json&access_token=#{token}")
          .to_return(response)
    end

    let!(:edit_stub) do
      stub_request(:put, "#{entry}/v1.1/companies/#{company_id}/absent-and-late")
          .with(body: { _format: 'json', access_token: 'TOKEN' })
          .to_return(response)
    end

    it '.absent_and_late' do
      client.absent_and_late(company_id: company_id)
      expect(get_stub).to have_been_requested
    end

    it '.edit_absent_and_late' do
      client.edit_absent_and_late(company_id: company_id)
      expect(edit_stub).to have_been_requested
    end
  end

  context 'companies' do
    let!(:get_companies) do
      stub_request(:get, "#{entry}/v1.1/companies?_format=json&access_token=#{token}")
        .to_return(response)
    end

    let!(:create_company) do
      stub_request(:post, "#{entry}/v1.1/companies")
          .with(body: { _format: 'json', name: 'NAME', access_token: 'TOKEN' })
          .to_return(response)
    end

    let!(:invite_user) do
      stub_request(:post, "#{entry}/v1.1/companies/invites")
          .with(body: { _format: 'json', emails: 'emails', access_token: 'TOKEN' })
          .to_return(response)
    end

    it '.companies' do
      client.companies
      expect(get_companies).to have_been_requested
    end

    it '.create_company' do
      client.create_company(name: 'NAME')
      expect(create_company).to have_been_requested
    end

    it '.invite_user' do
      client.invite_user(emails: 'emails')
      expect(invite_user).to have_been_requested
    end
  end

  context 'poor time' do
    let!(:stub) do
      stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/poortime" \
                         "?_format=json&access_token=#{token}")
        .to_return(response)
    end

    it '.poor_time' do
      client.poor_time(company_id: company_id)
      expect(stub).to have_been_requested
    end
  end

  context 'users' do
    let(:user_id) { 12 }

    let!(:users) do
      stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/users" \
                         "?_format=json&access_token=#{token}")
        .to_return(response)
    end

    let!(:user) do
      stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}" \
                         "?_format=json&access_token=#{token}")
          .to_return(response)
    end

    it '.users' do
      client.users(company_id: company_id)
      expect(users).to have_been_requested
    end

    it '.user' do
      client.user(company_id: company_id, user_id: user_id)
      expect(user).to have_been_requested
    end
  end

  context 'worklogs' do
    let!(:stub) do
      stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/worklogs" \
                         "?_format=json&access_token=#{token}")
        .to_return(response)
    end

    it '.worklogs' do
      client.worklogs(company_id: company_id)
      expect(stub).to have_been_requested
    end
  end

  context 'web and app' do
    let!(:stub) do
      stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/webandapp" \
                         "?_format=json&access_token=#{token}")
        .to_return(response)
    end

    it '.web_and_app' do
      client.web_and_app(company_id: company_id)
      expect(stub).to have_been_requested
    end
  end
end
