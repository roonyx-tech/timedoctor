RSpec.describe TimeDoctor::Token do
  subject { TimeDoctor::Token }

  context '#authorize' do
    let!(:authorize_stub) do
      stub_request(:get, 'https://webapi.timedoctor.com/oauth/v2/token' \
                       '?_format=json' \
                       "&client_id=#{client_id}" \
                       "&client_secret=#{client_secret}" \
                       '&code=CODE' \
                       '&grant_type=authorization_code' \
                       '&redirect_uri=example.com/redirect')
        .to_return(status: 200, body: JSON.generate(access_token: 'NAT', refresh_token: 'NRT'))
    end

    let!(:failure_authorize_stub) do
      stub_request(:get, 'https://webapi.timedoctor.com/oauth/v2/token' \
                       '?_format=json' \
                       "&client_id=#{client_id}" \
                       "&client_secret=#{client_secret}" \
                       '&code=BAD_CODE' \
                       '&grant_type=authorization_code' \
                       '&redirect_uri=example.com/redirect')
        .to_return(status: 400, body: JSON.generate(error: 'invalid_grant',
                                                    error_description: 'Invalid code'))
    end

    it 'when success' do
      result = nil

      config = TimeDoctor::Config.new client_id: client_id,
                                      client_secret: client_secret,
                                      code: 'CODE',
                                      redirect_uri: 'example.com/redirect',
                                      on_token_authorize: ->(_, _) { result = :success }
      subject.new(config).fetch
      expect(authorize_stub).to have_been_requested
      expect(result).to be(:success)
    end

    it 'when failure' do
      result = nil

      config = TimeDoctor::Config.new client_id: client_id,
                                      client_secret: client_secret,
                                      code: 'BAD_CODE',
                                      redirect_uri: 'example.com/redirect',
                                      on_token_authorize_error: ->(_, _) { result = :fail }
      subject.new(config).fetch
      expect(failure_authorize_stub).to have_been_requested
      expect(result).to be(:fail)
    end
  end

  context '#refresh' do
    let!(:refresh_stub) do
      stub_request(:get, 'https://webapi.timedoctor.com/oauth/v2/token' \
                       '?_format=json' \
                       "&client_id=#{client_id}" \
                       "&client_secret=#{client_secret}" \
                       '&grant_type=refresh_token' \
                       '&refresh_token=RT')
        .to_return(status: 200, body: JSON.generate(access_token: 'NAT', refresh_token: 'NRT'))
    end

    let!(:failure_refresh_stub) do
      stub_request(:get, 'https://webapi.timedoctor.com/oauth/v2/token' \
                       '?_format=json' \
                       "&client_id=#{client_id}" \
                       "&client_secret=#{client_secret}" \
                       '&grant_type=refresh_token' \
                       '&refresh_token=BAD')
        .to_return(status: 400, body: JSON.generate(error: 'invalid_grant',
                                                    error_description: 'Invalid refresh_token'))
    end

    it 'when success' do
      result = nil

      config = TimeDoctor::Config.new client_id: client_id,
                                      client_secret: client_secret,
                                      refresh_token: 'RT',
                                      on_token_refresh: ->(_, _) { result = :success }
      subject.new(config).refresh
      expect(refresh_stub).to have_been_requested
      expect(result).to be(:success)
    end

    it 'when failure' do
      result = nil

      config = TimeDoctor::Config.new client_id: client_id,
                                      client_secret: client_secret,
                                      refresh_token: 'BAD',
                                      on_token_refresh_error: ->(_, _) { result = :fail }
      subject.new(config).refresh
      expect(failure_refresh_stub).to have_been_requested
      expect(result).to be(:fail)
    end
  end
end
