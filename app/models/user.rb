class User < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :topics, join_table: :speakers_topics
  has_and_belongs_to_many :voted_topics, class_name: Topic, join_table: :voters_topics
  has_many :registered_topics, class_name: Topic, foreign_key: :registerer_id

  def admin?
    AdminUser.exists?(email: email)
  end
end
