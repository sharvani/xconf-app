require 'base64'

class SessionsController < ApplicationController
  skip_before_action :protected!, only: [:new, :create]
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    redirect_to "/auth/saml?redirectUrl=#{URI::encode(request.referer || "/")}"
  end

  def create
    response = Onelogin::Saml::Response.new(Base64.decode64(params[:SAMLResponse]))
    session[:user_id] = response.name_id
    session[:user_name] = "#{response.attributes[:first_name]} #{response.attributes[:last_name]}"
    redirect_to params[:RelayState] || '/'
  end

  def destroy
    session[:user_id] = nil
    session[:user_name] = nil
  end
end
