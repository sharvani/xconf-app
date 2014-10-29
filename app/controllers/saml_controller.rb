require 'base64'

class SamlController < ApplicationController

  def auth
    response = Onelogin::Saml::Response.new(Base64.decode64(params[:SAMLResponse]))
    Rails.log response
    session[:user_id] = "SET"
    redirect_to params[:RelayState] || '/'
  end
end