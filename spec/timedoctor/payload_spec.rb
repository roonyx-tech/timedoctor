RSpec.describe TimeDoctor::Payload do
  subject { TimeDoctor::Payload.new(a: 1, b: 2) }

  it '.[]' do
    expect(subject[:a]).to be(1)
  end

  it '.[]=' do
    subject[:a] = 3

    expect(subject[:a]).to be(3)
    expect(subject[:nil]).to be_nil
  end

  it 'call' do
    subject[:cb] = ->(a, b, payload) { payload[:foo] = a + b }
    subject.call(:cb, 2, 5)
    expect(subject[:foo]).to be(7)
  end
end
