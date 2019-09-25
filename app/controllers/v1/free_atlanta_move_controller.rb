class V1::FreeAtlantaMoveController < ApplicationController
  def home_form_submission
    # TODO: Build of functionality to save form submission data and respond with success JSON.
    render json: { success: true }
  end
end
