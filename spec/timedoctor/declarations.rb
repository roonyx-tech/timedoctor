require 'securerandom'

module Declarations
  extend RSpec::SharedContext

  let(:entry)      { 'https://webapi.timedoctor.com' }
  let(:token)      { SecureRandom.hex(10) }
  let(:client)     { described_class.new token }
  let(:company_id) { Random.new.rand(1000) }
  let(:payroll_id) { Random.new.rand(1000) }
  let(:user_id)    { Random.new.rand(1000) }
  let(:task_id)    { Random.new.rand(1000) }
  let(:response) do
    {
      status: 200,
      body: JSON.generate({})
    }
  end
end
