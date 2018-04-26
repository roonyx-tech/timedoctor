RSpec.describe TimeDoctor::Client do
  let(:client) { described_class.new token }

  it '.absent_and_late' do
    expect(client.absent_and_late).to be_a TimeDoctor::AbsentAndLate
  end

  it '.companies' do
    expect(client.companies).to be_a TimeDoctor::Companies
  end

  it '.payrolls' do
    expect(client.payrolls).to be_a TimeDoctor::Payrolls
  end

  it '.poortime' do
    expect(client.poortime).to be_a TimeDoctor::Poortime
  end

  it '.projects' do
    expect(client.projects).to be_a TimeDoctor::Projects
  end

  it '.tasks' do
    expect(client.tasks).to be_a TimeDoctor::Tasks
  end

  it '.users' do
    expect(client.users).to be_a TimeDoctor::Users
  end

  it '.web_and_app' do
    expect(client.web_and_app).to be_a TimeDoctor::WebAndApp
  end

  it '.worklogs' do
    expect(client.worklogs).to be_a TimeDoctor::Worklogs
  end
end
