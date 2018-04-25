RSpec.describe TimeDoctor::Companies do
  let!(:list_stub) do
    stub_request(:get, "#{entry}/v1.1/companies?_format=json&access_token=#{token}")
      .to_return(response)
  end

  let!(:create_stub) do
    stub_request(:post, "#{entry}/v1.1/companies")
      .with(body: { _format: 'json', name: 'NAME', access_token: token })
      .to_return(response)
  end

  let!(:invite_user_stub) do
    stub_request(:post, "#{entry}/v1.1/companies/invites")
      .with(body: { _format: 'json', emails: 'emails', access_token: token })
      .to_return(response)
  end

  it '.list' do
    client.list
    expect(list_stub).to have_been_requested
  end

  it '.create' do
    client.create(name: 'NAME')
    expect(create_stub).to have_been_requested
  end

  it '.invite_user' do
    client.invite_user(emails: 'emails')
    expect(invite_user_stub).to have_been_requested
  end
end
