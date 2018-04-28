RSpec.describe TimeDoctor::Core::Payrolls do
  let!(:list_stub) do
    stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/payrolls" \
                         "?_format=json&access_token=#{token}")
      .to_return(response)
  end

  let!(:update_stub) do
    stub_request(:put, "#{entry}/v1.1/companies/#{company_id}/payrolls/#{payroll_id}")
      .to_return(response)
  end

  it '.list' do
    client.list(company_id: company_id)
    expect(list_stub).to have_been_requested
  end

  it '.update' do
    client.update(company_id: company_id, payroll_id: payroll_id)
    expect(update_stub).to have_been_requested
  end
end
