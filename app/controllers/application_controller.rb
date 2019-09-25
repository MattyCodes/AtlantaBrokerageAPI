class ApplicationController < ActionController::API
  before_action :validate_request_host!

  CONTROLLER_DOMAIN_WHITELIST = {
    'free_atlanta_move' => 'free-atlanta-move.herokuapp.com'
  }

  def validate_request_host!
    invalid_request! unless requesting_domain.present? && CONTROLLER_DOMAIN_WHITELIST[controller_name].include?(requesting_domain)
  end

  def invalid_request!
    render json: { success: false, body: 'This request is invalid, please ensure that it is being sent from the appropriate domain.' } and return
  end

  def controller_name
    params[:controller].split('/').last if params[:controller].present?
  end

  def requesting_domain
    URI(request.referer).host if request.present? && request.referer.present?
  end
end
