class Topic < ActiveRecord::Base

  validates :title, :description, presence: true

  has_and_belongs_to_many :speakers, class_name: User, join_table: :speakers_topics
  has_many :voters, class_name: User
  has_one :registerer, class_name: User, foreign_key: 'topic_registerer_id'

  def save_with_registerer(current_user)
    if save
      self.registerer = User.create(name: current_user)
      self.speakers << User.find_by(name: current_user)
    end
  end

  def add_speakers_to_topic(speakers)
    speakers_array = speakers.split(',')
    speakers_array.each { |speaker|
      speaker = speaker.strip! || speaker
      self.speakers << User.find_or_create_by(name: speaker)
    }
  end

end
