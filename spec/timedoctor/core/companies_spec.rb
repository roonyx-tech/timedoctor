RSpec.describe TimeDoctor::Core::Companies do
  subject { client.companies }

  let!(:list_stub) do
    stub_request(:get, "#{entry}/v1.1/companies?_format=json&access_token=#{access_token}")
      .to_return(response)
  end

  let!(:create_stub) do
    stub_request(:post, "#{entry}/v1.1/companies")
      .with(body: { _format: 'json', name: 'NAME', access_token: access_token })
      .to_return(response)
  end

  let!(:invite_user_stub) do
    stub_request(:post, "#{entry}/v1.1/companies/invites")
      .with(body: { _format: 'json', emails: 'emails', access_token: access_token })
      .to_return(response)
  end

  it '.list' do
    subject.list
    expect(list_stub).to have_been_requested
  end

  it '.create' do
    subject.create(name: 'NAME')
    expect(create_stub).to have_been_requested
  end

  it '.invite_user' do
    subject.invite_user(emails: 'emails')
    expect(invite_user_stub).to have_been_requested
  end
end
