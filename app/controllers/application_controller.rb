class ApplicationController < ActionController::API
  before_action :validate_request_host!

  # This whitelist determines which controllers a domain is authorized to 
  # interact with. For example the domain "free-atlanta-move.herokuapp.com" is
  # only authorized to interact with the `FreeAtlantaMoveController`.
  CONTROLLER_DOMAIN_WHITELIST = {
    'free_atlanta_move' => 'free-atlanta-move.herokuapp.com'
  }

  def validate_request_host!
    invalid_request! unless the_request_is_from_an_authorized_domain?
  end

  def the_request_is_from_an_authorized_domain?
    requesting_domain.present? && 
      CONTROLLER_DOMAIN_WHITELIST[controller_name].include?(requesting_domain)
  end

  def invalid_request!
    render json: { 
      success: false,
      status: 402,
      body: 'Unauthorized domain.' 
    }
  end

  def controller_name
    params[:controller].split('/').last if params[:controller].present?
  end

  def requesting_domain
    URI(request.referer).host if request.present? && request.referer.present?
  end
end
