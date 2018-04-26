RSpec.describe TimeDoctor::Tasks do
  let!(:list_stub) do
    stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}/tasks" \
                       "?_format=json&access_token=#{token}")
      .to_return(response)
  end

  let!(:create_stub) do
    stub_request(:post, "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}/tasks")
      .with(body: { _format: 'json', access_token: token })
      .to_return(response)
  end

  let!(:info_stub) do
    stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}/tasks/#{task_id}" \
                       "?_format=json&access_token=#{token}")
      .to_return(response)
  end

  let!(:update_stub) do
    stub_request(:put, "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}/tasks/#{task_id}")
      .with(body: { _format: 'json', access_token: token })
      .to_return(response)
  end

  it '.list' do
    client.list(company_id: company_id, user_id: user_id)
    expect(list_stub).to have_been_requested
  end

  it '.create' do
    client.create(company_id: company_id, user_id: user_id)
    expect(create_stub).to have_been_requested
  end

  it '.info' do
    client.info(company_id: company_id, user_id: user_id, task_id: task_id)
    expect(info_stub).to have_been_requested
  end

  it '.update' do
    client.update(company_id: company_id, user_id: user_id, task_id: task_id)
    expect(update_stub).to have_been_requested
  end
end
