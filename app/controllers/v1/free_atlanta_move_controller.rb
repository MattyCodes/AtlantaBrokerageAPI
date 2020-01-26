# Controller actions for the free-atlanta-move website.
class V1::FreeAtlantaMoveController < ApplicationController
  def home_form_submission
    # TODO: Build of functionality to save form submission data.
    success = (params[:email] || '').match?(Constants::VALID_EMAIL_REGEX)
    message = success ? nil : 'Please submit a valid email address.'

    render json: { success: success, message: message }
  end
end
