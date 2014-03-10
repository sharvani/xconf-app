class UsersController < ApplicationController

  def my_topics
    @current_user = session[:cas_user]
    user = User.find_by(name: @current_user)
    @my_talks = 'active'
    if user.nil?
      []
    else
      registered_topics = user.registered_topics.order('id desc')
      voted_topics = user.voted_topics.order('id desc')
      @topics = registered_topics.zip(voted_topics).flatten.compact.uniq


      @topicUserVoteStatus = []
      @topics.each { |topic|
        vote_status = 'vote-open'
        topic.voters.each { |voter|
          if voter.name == @current_user
            vote_status = 'vote-cast'
            break
          end
        }
        @topicUserVoteStatus << vote_status
      }

    end
  end
end
