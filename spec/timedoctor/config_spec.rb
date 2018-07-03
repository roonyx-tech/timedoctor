RSpec.describe TimeDoctor::Config do
  subject { described_class }

  it '#configure' do
    params = { a: 1, b: 2 }

    subject.configure(params)
    expect(subject.inspect).to include(:a, :b,
                                       :on_token_authorize, :on_token_authorize_error,
                                       :on_token_refresh, :on_token_refresh_error)
  end

  it '#[]' do
    expect(subject[:a]).to eq(1)
    expect(subject[:z]).to be_nil
  end

  it '#[]=' do
    subject[:z] = 5
    expect(subject[:z]).to eq(5)
  end
end
