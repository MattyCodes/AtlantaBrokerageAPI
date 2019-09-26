require 'rails_helper'

RSpec.describe V1::FreeAtlantaMoveController, type: :controller do
  TEST_CONTROLLER_DOMAIN_WHITELIST = { 'free_atlanta_move' => 'example.com' }

  it 'Responds with a success JSON when the request host is valid.' do
    allow_any_instance_of(ActionController::TestRequest).to receive(:referer).and_return('https://example.com')
    stub_const('ApplicationController::CONTROLLER_DOMAIN_WHITELIST', TEST_CONTROLLER_DOMAIN_WHITELIST)
    post :home_form_submission, params: { email: 'testing@example.com' }
    expect(response).to be_successful
    expect(JSON.parse(response.body)['success']).to eq true
  end

  it 'Responds with a success JSON when the request host is valid.' do
    allow_any_instance_of(ActionController::TestRequest).to receive(:referer).and_return('invalid.host')
    stub_const('ApplicationController::CONTROLLER_DOMAIN_WHITELIST', TEST_CONTROLLER_DOMAIN_WHITELIST)
    post :home_form_submission
    expect(response).to be_successful
    expect(JSON.parse(response.body)['success']).to eq false
  end
end
