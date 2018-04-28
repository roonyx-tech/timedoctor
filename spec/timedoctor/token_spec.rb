RSpec.describe TimeDoctor::Token do
  context 'when refresh token is valid' do
    let!(:refresh_stub) do
      stub_request(:get, "#{entry}/oauth/v2/token" \
                         '?client_id=CLIENT_ID' \
                         '&client_secret=CLIENT_SECRET' \
                         '&grant_type=refresh_token' \
                         '&refresh_token=REFRESH_TOKEN')
        .to_return(status: 200,
                   body: JSON.generate(access_token:  'NEW_ACCESS_TOKEN',
                                       refresh_token: 'NEW_REFRESH_TOKEN'))
    end

    it '#refresh' do
      response = TimeDoctor::Token.refresh refresh_token: 'REFRESH_TOKEN',
                                           client_id:     'CLIENT_ID',
                                           client_secret: 'CLIENT_SECRET'

      expect(refresh_stub).to have_been_requested
      expect(response[:access_token]).to eq('NEW_ACCESS_TOKEN')
      expect(response[:refresh_token]).to eq('NEW_REFRESH_TOKEN')
    end
  end

  context 'when refresh token is not valid' do
    let!(:refresh_stub) do
      stub_request(:get, "#{entry}/oauth/v2/token" \
                         '?client_id=CLIENT_ID' \
                         '&client_secret=CLIENT_SECRET' \
                         '&grant_type=refresh_token' \
                         '&refresh_token=REFRESH_TOKEN')
        .to_return(status: 400, body: JSON.generate({}))
    end

    it '#refresh' do
      params = { refresh_token: 'REFRESH_TOKEN',
                 client_id:     'CLIENT_ID',
                 client_secret: 'CLIENT_SECRET' }

      expect { TimeDoctor::Token.refresh params }
        .to raise_error(TimeDoctor::InvalidRefreshTokenError)
    end
  end

  context 'when unknown error' do
    let!(:refresh_stub) do
      stub_request(:get, "#{entry}/oauth/v2/token" \
                         '?client_id=CLIENT_ID' \
                         '&client_secret=CLIENT_SECRET' \
                         '&grant_type=refresh_token' \
                         '&refresh_token=REFRESH_TOKEN')
        .to_return(status: 500, body: JSON.generate({error: true}))
    end

    it '#refresh' do
      params = { refresh_token: 'REFRESH_TOKEN',
                 client_id:     'CLIENT_ID',
                 client_secret: 'CLIENT_SECRET' }

      expect { TimeDoctor::Token.refresh params }
        .to raise_error(TimeDoctor::UnknownError)
    end
  end
end
