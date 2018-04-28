RSpec.describe TimeDoctor::Core::Fake do
  let!(:success_stub) do
    stub_request(:post, "#{entry}/success")
      .to_return(response)
  end

  let!(:token_expired_stub) do
    stub_request(:post, "#{entry}/expired_token")
      .to_return(status: 401,
                 body: JSON.generate(error: 'invalid_grant',
                                     error_description: 'The access token provided is invalid.'))
  end

  let!(:unknown_error_stub) do
    stub_request(:post, "#{entry}/unknown_error")
      .to_return(status: 500, body: JSON.generate({}))
  end

  it 'when success' do
    client.success
    expect(success_stub).to have_been_requested
  end

  it 'when token expired' do
    expect { client.expired_token }.to raise_error(TimeDoctor::UnauthorizedError)
  end

  it 'when unknown error' do
    expect { client.unknown_error }.to raise_error(TimeDoctor::UnknownError)
  end
end
