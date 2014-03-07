class Topic < ActiveRecord::Base

  validates_presence_of :title, :category, :description

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
    if check_for_limit(new_speakers_names, current_speakers_names)
      return false, "You can't add more than five speakers"
    end
    already_added_speakers = has_already_added(current_speakers_names, new_speakers_names)
    if already_added_speakers.blank?
      add_speakers(new_speakers_names)
      return true, nil
    else
      return false, already_added_speakers.map { |x| "'" + x + "'" }.join(',') + ' has already been added as a speaker'
    end

  end

  def check_for_limit(new_speakers, current_speakers)
    return new_speakers.length + current_speakers.length > 5
  end

  def has_already_added(current_speakers, new_speakers)
    already_added_speakers = []
    new_speakers.each { |speaker|
      speaker = speaker.strip! || speaker
      if current_speakers.include? speaker
        already_added_speakers << speaker
      end
    }
    already_added_speakers
  end

  def add_speakers (new_speakers_names)
    new_speakers_names.each{ | speaker |
      speaker = speaker.strip! || speaker
      self.speakers << User.find_or_create_by(name: speaker)
    }
  end


end
