class LoginController < ApplicationController

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
