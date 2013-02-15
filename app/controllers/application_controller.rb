class ApplicationController < ActionController::Base
  protect_from_forgery

  # CanCan error handling
   rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.referer || root_url, :alert => exception.message
  end
end
