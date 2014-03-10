class LogoutController < ApplicationController

  def index
    @logout_active = 'active'
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
