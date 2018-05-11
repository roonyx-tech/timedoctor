RSpec.describe TimeDoctor::Core::Users do
  subject { client.users }

  let!(:list_stub) do
    stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/users" \
                       "?_format=json&access_token=#{access_token}")
      .to_return(response)
  end

  let!(:info_stub) do
    stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}" \
                       "?_format=json&access_token=#{access_token}")
      .to_return(response)
  end

  it '.list' do
    subject.list(company_id: company_id)
    expect(list_stub).to have_been_requested
  end

  it '.info' do
    subject.info(company_id: company_id, user_id: user_id)
    expect(info_stub).to have_been_requested
  end
end
