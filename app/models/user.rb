class User < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :topics, join_table: :speakers_topics
  has_and_belongs_to_many :voted_topics, class_name: Topic, join_table: :voters_topics

  def get_registered_topics(current_user)
    registered_topics = []

    self.topics.order('id desc').each { |topic|
      if topic.registerer.name == current_user
        registered_topics << topic
      end
    }
    registered_topics
  end
end
