require 'base64'

class SessionsController < ApplicationController
  skip_before_action :protected!, only: [:new, :create]
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    redirect_to "/auth/saml?redirectUrl=#{URI::encode(request.path)}"
  end

  def create
    response = Onelogin::Saml::Response.new(Base64.decode64(params[:SAMLResponse]))
    Rails.logger.error response.to_hash
    session[:user_id] = response.name_id
    redirect_to params[:RelayState] || '/'
  end

  def destroy
    session[:user_id] = nil
  end
end
