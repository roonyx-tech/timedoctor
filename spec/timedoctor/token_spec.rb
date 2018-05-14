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

    it 'when callback presents' do
      payload = {
        client_id: client_id,
        client_secret: client_secret,
        code: 'CODE',
        redirect_uri: 'example.com/redirect',
        on_token_authorize: ->(_data, p) { p[:test] = :success }
      }
      subject.authorize payload
      expect(authorize_stub).to have_been_requested
      expect(payload[:test]).to be(:success)
    end

    it 'when callback blanks' do
      subject.authorize client_id: client_id,
                        client_secret: client_secret,
                        code: 'CODE',
                        redirect_uri: 'example.com/redirect'
      expect(authorize_stub).to have_been_requested
    end
  end
end
