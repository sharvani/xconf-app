require 'base64'

class SamlController < ApplicationController
  skip_before_action :protected!

  def auth
    response = Onelogin::Saml::Response.new(Base64.decode64(params[:SAMLResponse]))
    Rails.logger.error response.inspect
    session[:user_id] = response.name_id
    redirect_to params[:RelayState] || '/'
  end
end
