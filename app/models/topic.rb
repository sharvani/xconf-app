class Topic < ActiveRecord::Base

  validates_presence_of :title, :category, :description

  has_and_belongs_to_many :speakers, class_name: User, join_table: :speakers_topics
  has_and_belongs_to_many :voters, class_name: User, join_table: :voters_topics
  belongs_to :registerer, class_name: User
  belongs_to :category

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

  def add_speakers (speakers)
    speakers.split(",").each { |speaker|
      speaker = speaker.strip! || speaker
      self.speakers << User.find_or_create_by(name: speaker)
    }
  end

  def remove_speakers
    current_speakers = self.speakers
    current_speakers.each { |speaker|
      current_speakers.delete(speaker)
    }
  end


  def getUserTopicVoteStatus(topics, current_user)
    @topicUserVoteStatus = []
    user = User.find_or_create_by(name: current_user)
    topics.each { |topic|
      vote_status = 'vote-open'
      if user.voted_topics.include? topic
        vote_status = 'vote-cast'
      end
      @topicUserVoteStatus << vote_status
    }
    @topicUserVoteStatus
  end

end
