class UsersController < ApplicationController

  def own_topics
    @current_user = session[:cas_user]
    user = User.find_by(name: @current_user)
    if user.nil?
      []
    else
      @topics = user.get_registered_topics(@current_user)
    end
  end

  def voted_topics
    @current_user = session[:cas_user]
    user = User.find_by(name: @current_user)
    if user.nil?
      []
    else
      @topics = user.voted_topics
    end

  end

end
