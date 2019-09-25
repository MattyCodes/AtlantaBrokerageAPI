require 'rails_helper'

RSpec.describe V1::FreeAtlantaMoveController, type: :controller do
  TEST_CONTROLLER_DOMAIN_WHITELIST = { 'free_atlanta_move' => 'localhost' }

  it 'Responds with a success JSON when the request host is valid.' do
    @request.host = 'localhost'

    stub_const('ApplicationController::CONTROLLER_DOMAIN_WHITELIST', TEST_CONTROLLER_DOMAIN_WHITELIST)
    post :home_form_submission, params: { email: 'testing@example.com' }
    expect(response).to be_success
    expect(JSON.parse(response.body)['success']).to eq true
  end

  it 'Responds with a success JSON when the request host is valid.' do
    @request.host = 'invalid.host'

    stub_const('ApplicationController::CONTROLLER_DOMAIN_WHITELIST', TEST_CONTROLLER_DOMAIN_WHITELIST)
    post :home_form_submission
    expect(response).to be_success
    expect(JSON.parse(response.body)['success']).to eq false
  end
end
