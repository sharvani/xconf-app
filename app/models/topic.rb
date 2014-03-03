class Topic < ActiveRecord::Base

  validates :title, :description, presence: true

  has_and_belongs_to_many :speakers, class_name: User, join_table: :speakers_topics
  has_many :voters, class_name: User
  has_one :registerer, class_name: User

  def save_with_registerer(current_user)
    if save
      self.registerer = User.find_or_create_by(name: current_user)
      binding.pry
      speakers << User.find_by(name: current_user)
    end
  end

end
