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

  def add_speakers (speakers)
    speakers.split(",").each{ | speaker |
      speaker = speaker.strip! || speaker
      self.speakers << User.find_or_create_by(name: speaker)
    }
  end


end
