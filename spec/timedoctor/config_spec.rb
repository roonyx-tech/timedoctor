RSpec.describe TimeDoctor::Config do
  subject { described_class }

  it '#configure' do
    params = { a: 1, b: 2, c: 3 }
    subject.configure(params)
    expect(subject.inspect).to eq(params)
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
