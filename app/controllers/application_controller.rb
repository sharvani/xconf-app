class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :protected!
  force_ssl
  protect_from_forgery with: :exception

  def current_user
    user = User.find_by(email: session[:user_id])
    @current_user ||= user.present? ? user : User.create(email: session[:user_id], name: session[:user_name])
  end

  private
    def protected!
      return if authorized?
      redirect_to "/sessions/new"
    end

    def authorized?
      !session[:user_id].nil?
    end
end
