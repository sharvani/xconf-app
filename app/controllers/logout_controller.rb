class LogoutController < ApplicationController

  def index
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
