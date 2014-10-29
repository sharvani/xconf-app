class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :protected!
  protect_from_forgery with: :exception

  private
    def protected!
      return if authorized?
      redirect_to "/sessions/new"
    end

    def authorized?
      !session[:user_id].nil?
    end
end
