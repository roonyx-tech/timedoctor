require 'ostruct'

RSpec.describe TimeDoctor::TimeDoctorError do
  RESPONSE = {
    status: 500,
    body: JSON.generate(
      status: 500,
      success: false,
      message: 'this is message'
    )
  }.freeze

  let(:response) { OpenStruct.new(RESPONSE) }

  it 'when raise' do
    begin
      raise TimeDoctor::UnknownError, response
    rescue TimeDoctor::UnknownError => ex
      expect(ex.message).not_to be nil
    end
  end
end
