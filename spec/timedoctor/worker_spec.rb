module TimeDoctor
  module Core
    class Fake < Base
      def success
        exchange :post, '/success'
      end

      def expired_token
        exchange :post, '/expired_token'
      end

      def unknown_error
        exchange :post, '/unknown_error'
      end
    end
  end
end

RSpec.describe TimeDoctor::Worker do
  subject { TimeDoctor::Core::Fake.new(client.instance_variable_get(:@worker)) }

  context 'when token valid' do
    let!(:success) do
      stub_request(:post, 'https://webapi.timedoctor.com/success')
        .to_return(status: 200, body: JSON.generate({}))
    end

    it 'success' do
      subject.success
      expect(success).to have_been_requested
    end
  end

  context 'when token invalid' do
    context 'when refresh token is valid' do
      let!(:inspired_stub) do
        stub_request(:post, 'https://webapi.timedoctor.com/expired_token')
          .with(body: { _format: 'json', access_token: access_token })
          .to_return(status: 401, body: JSON.generate({}))
      end

      let!(:refresh_token_stub) do
        stub_request(:get, 'https://webapi.timedoctor.com/oauth/v2/token' \
                           '?_format=json' \
                           "&client_id=#{client_id}" \
                           "&client_secret=#{client_secret}" \
                           '&grant_type=refresh_token' \
                           "&refresh_token=#{refresh_token}")
          .to_return(status: 200, body: JSON.generate(access_token: 'NAT', refresh_token: 'NRT'))
      end

      let!(:updated_stub) do
        stub_request(:post, 'https://webapi.timedoctor.com/expired_token')
          .with(body: { _format: 'json', access_token: 'NAT' })
          .to_return(status: 200, body: JSON.generate({}))
      end

      it 'expired_token' do
        subject.expired_token
        expect(inspired_stub).to have_been_requested
        expect(refresh_token_stub).to have_been_requested
        expect(updated_stub).to have_been_requested
      end
    end

    context 'when unknown error while refresh token' do
      let!(:inspired_stub) do
        stub_request(:post, 'https://webapi.timedoctor.com/expired_token')
          .with(body: { _format: 'json', access_token: access_token })
          .to_return(status: 401, body: JSON.generate({}))
      end

      let!(:refresh_token_stub) do
        stub_request(:get, 'https://webapi.timedoctor.com/oauth/v2/token' \
                         '?_format=json' \
                         "&client_id=#{client_id}" \
                         "&client_secret=#{client_secret}" \
                         '&grant_type=refresh_token' \
                         "&refresh_token=#{refresh_token}")
          .to_return(status: 400, body: JSON.generate(error: 'error'))
      end

      it 'expired_token' do
        expect { subject.expired_token }.to raise_error TimeDoctor::UnknownError

        expect(inspired_stub).to have_been_requested
        expect(refresh_token_stub).to have_been_requested
      end
    end
  end

  context 'when unknown error' do
    let!(:unknown_error_stub) do
      stub_request(:post, 'https://webapi.timedoctor.com/unknown_error')
        .with(body: { _format: 'json', access_token: access_token })
        .to_return(status: 500, body: JSON.generate({}))
    end

    it 'expired_token' do
      expect { subject.unknown_error }.to raise_error TimeDoctor::UnknownError

      expect(unknown_error_stub).to have_been_requested
    end
  end
end
