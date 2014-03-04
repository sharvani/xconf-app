class UsersController < ApplicationController

  def own_topics
    @current_user = session[:cas_user]
    user = User.find_by(name: @current_user)
    if user.nil?
      []
    else
      @topics = user.topics
    end
  end

end
