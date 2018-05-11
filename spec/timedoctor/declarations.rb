require 'securerandom'

module Declarations
  extend RSpec::SharedContext

  let(:entry)         { 'https://webapi.timedoctor.com' }

  let(:access_token)  { SecureRandom.hex(10) }
  let(:refresh_token) { SecureRandom.hex(10) }

  let(:client_id)     { SecureRandom.hex(10) }
  let(:client_secret) { SecureRandom.hex(10) }

  let(:company_id)    { Random.new.rand(1000) }
  let(:project_id)    { Random.new.rand(1000) }
  let(:payroll_id)    { Random.new.rand(1000) }
  let(:user_id)       { Random.new.rand(1000) }
  let(:task_id)       { Random.new.rand(1000) }

  let(:response) do
    { status: 200, body: JSON.generate({}) }
  end

  let(:client) do
    init = { access_token:  access_token,
             refresh_token: refresh_token,
             client_id: client_id,
             client_secret: client_secret }
    TimeDoctor::Client.new(init)
  end
end
