RSpec.describe TimeDoctor::Users do
  let!(:list_stub) do
    stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/users" \
                       "?_format=json&access_token=#{token}")
      .to_return(response)
  end

  let!(:info_stub) do
    stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}" \
                       "?_format=json&access_token=#{token}")
      .to_return(response)
  end

  it '.list' do
    client.list(company_id: company_id)
    expect(list_stub).to have_been_requested
  end

  it '.info' do
    client.info(company_id: company_id, user_id: user_id)
    expect(info_stub).to have_been_requested
  end
end
