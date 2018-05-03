RSpec.describe TimeDoctor::Config do
  let(:conf) { described_class }

  it '#config' do
    expect(conf.config).to eq({})
  end

  it '#configure' do
    params = { a: 1, b: 2, c: 3 }
    expect(conf.configure(params)).to eq(params)
    expect(conf.config).to eq(params)
  end

  it '#[]' do
    expect(conf[:a]).to eq(1)
    expect(conf[:z]).to be_nil
  end

  it '#[]=' do
    conf[:z] = 5
    expect(conf[:z]).to eq(5)
  end
end
