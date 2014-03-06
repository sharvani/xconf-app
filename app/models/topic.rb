class Topic < ActiveRecord::Base

  validates_presence_of :title, :duration, :description
  validates_numericality_of :duration, only_integer: true

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
    current_speakers_names = self.get_speakers_names
    speakers_array.each { |speaker|
    speaker = speaker.strip! || speaker
    if current_speakers_names.include? speaker
        return false, speaker
      else
        self.speakers << User.find_or_create_by(name: speaker)
      end
    }
    return true, nil
  end

  def get_speakers_names
    speakers_names = []
    self.speakers.each { |speaker|
      speakers_names << speaker.name
    }
    speakers_names
  end

end
