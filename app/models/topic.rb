class Topic < ActiveRecord::Base
  validates :title, :description, presence: true

  has_and_belongs_to_many :speakers, join_table: :speakers_topics

  def save_with_speaker(current_user)
    save
    speakers << Speaker.find_or_create_by(name: current_user)
  end

end
