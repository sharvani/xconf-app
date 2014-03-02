class Topic < ActiveRecord::Base

  validates :title, :description, presence: true

  has_and_belongs_to_many :speakers, class_name: User, join_table: :speakers_topics
  has_many :voters, class_name: User

  def save_with_speaker(current_user)
    if save
      speaker = User.find_or_create_by(name: current_user)
      speakers << speaker
      SpeakersTopics.where(topic_id: self.id, user_id: speaker.id).update_all(has_registered: true)
    end
  end

end
