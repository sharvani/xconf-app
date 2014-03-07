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
    new_speakers_names = speakers.split(',')
    current_speakers_names = self.speakers.pluck(:name)
    already_added_speakers = has_already_added(current_speakers_names, new_speakers_names)
    if already_added_speakers.blank?
      new_speakers_names.each{ | speaker |
        self.speakers << User.find_or_create_by(name: speaker)
      }
      return true, nil
    else
      return false, already_added_speakers
    end

  end

  def has_already_added(current_speakers, new_speakers)
    already_added_speakers = []
    new_speakers.each { |speaker|
      if current_speakers.include? speaker
        already_added_speakers << speaker
      end
    }
    already_added_speakers
  end

end
