RSpec.describe TimeDoctor::Core::Worklogs do
  subject { client.worklogs }

  let!(:list_stub) do
    stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/worklogs" \
                       "?_format=json&access_token=#{access_token}")
      .to_return(response)
  end

  it '.list' do
    subject.list(company_id: company_id)
    expect(list_stub).to have_been_requested
  end
end
