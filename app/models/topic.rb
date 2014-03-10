class Topic < ActiveRecord::Base

  validates_presence_of :title, :category, :description

  has_and_belongs_to_many :speakers, class_name: User, join_table: :speakers_topics
  has_and_belongs_to_many :voters, class_name: User, join_table: :voters_topics
  belongs_to :registerer, class_name: User

  def save_with_registerer_and_speakers(current_user, speakers)
    if save
      user = User.find_or_create_by(name: current_user)
      user.registered_topics << self
      self.add_speakers(speakers)
    end
  end

  def update_with_speakers(params)
    if self.update(params[:topic].permit(:title, :category, :description))
      self.remove_speakers
      self.add_speakers(params[:speakers])
    end
  end

  def getUserTopicVoteStatus(topics, current_user)
    @topicUserVoteStatus = []
    topics.each { |topic|
      vote_status = 'vote-open'
      topic.voters.each { |voter|
        if voter.name == current_user
          vote_status = 'vote-cast'
          break
        end
      }
      @topicUserVoteStatus << vote_status
    }
    @topicUserVoteStatus
  end

end
