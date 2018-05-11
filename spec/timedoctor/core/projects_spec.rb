RSpec.describe TimeDoctor::Core::Projects do
  subject { client.projects }

  let!(:list_stub) do
    stub_request(:get, "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}/projects" \
                       "?_format=json&access_token=#{access_token}")
      .to_return(response)
  end

  let!(:create_stub) do
    stub_request(:post, "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}/projects")
      .with(body: { _format: 'json', access_token: access_token })
      .to_return(response)
  end

  let!(:delete_stub) do
    stub_request(:delete,
                 "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}" \
                 "?_format=json&access_token=#{access_token}")
      .to_return(response)
  end

  let!(:info_stub) do
    stub_request(:get,
                 "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}" \
                 "?_format=json&access_token=#{access_token}")
      .to_return(response)
  end

  let!(:assign_user_stub) do
    stub_request(:put,
                 "#{entry}/v1.1/companies/#{company_id}/users/#{user_id}/projects/#{project_id}")
      .with(body: { _format: 'json', access_token: access_token })
      .to_return(response)
  end

  let!(:unassign_user_stub) do
    stub_request(:delete,
                 "#{entry}/v1.1/companies/#{company_id}/" \
                 "users/#{user_id}/projects/#{project_id}/users" \
                 "?_format=json&access_token=#{access_token}")
      .to_return(response)
  end

  it '.list' do
    subject.list(company_id: company_id, user_id: user_id)
    expect(list_stub).to have_been_requested
  end

  it '.create' do
    subject.create(company_id: company_id, user_id: user_id)
    expect(create_stub).to have_been_requested
  end

  it '.delete' do
    subject.delete(company_id: company_id, user_id: user_id, project_id: project_id)
    expect(delete_stub).to have_been_requested
  end

  it '.info' do
    subject.info(company_id: company_id, user_id: user_id, project_id: project_id)
    expect(info_stub).to have_been_requested
  end

  it '.assign_user' do
    subject.assign_user(company_id: company_id, user_id: user_id, project_id: project_id)
    expect(assign_user_stub).to have_been_requested
  end

  it '.unassign_user' do
    subject.unassign_user(company_id: company_id, user_id: user_id, project_id: project_id)
    expect(unassign_user_stub).to have_been_requested
  end
end
