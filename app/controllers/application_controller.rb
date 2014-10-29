class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :protected!
  protect_from_forgery with: :exception, except: :auth

  private
    def protected!
      return if authorized?
      redirect_to "/auth/saml?redirectUrl=#{URI::encode(request.path)}"
    end

    def authorized?
      !session[:user_id].nil?
    end
end
