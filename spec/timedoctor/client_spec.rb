RSpec.describe TimeDoctor::Client do
  let(:core) { described_class.new token }

  it '.absent_and_late' do
    expect(client.absent_and_late).to be_a TimeDoctor::Core::AbsentAndLate
  end

  it '.companies' do
    expect(client.companies).to be_a TimeDoctor::Core::Companies
  end

  it '.payrolls' do
    expect(client.payrolls).to be_a TimeDoctor::Core::Payrolls
  end

  it '.poortime' do
    expect(client.poortime).to be_a TimeDoctor::Core::Poortime
  end

  it '.projects' do
    expect(client.projects).to be_a TimeDoctor::Core::Projects
  end

  it '.tasks' do
    expect(client.tasks).to be_a TimeDoctor::Core::Tasks
  end

  it '.users' do
    expect(client.users).to be_a TimeDoctor::Core::Users
  end

  it '.web_and_app' do
    expect(client.web_and_app).to be_a TimeDoctor::Core::WebAndApp
  end

  it '.worklogs' do
    expect(client.worklogs).to be_a TimeDoctor::Core::Worklogs
  end
end
