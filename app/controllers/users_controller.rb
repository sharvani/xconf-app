class UsersController < ApplicationController

  def my_topics
    @current_user = session[:user_id]
    user = User.find_by(name: @current_user)
    @my_talks = 'active'
    if user.nil?
      []
    else
      registered_topics = user.registered_topics.order('id desc')
      voted_topics = user.voted_topics.order('id desc')
      @topics = registered_topics.concat(voted_topics).uniq
      @topicUserVoteStatus = Topic.new.getUserTopicVoteStatus(@topics, @current_user)
    end
  end
end
