class User < ActiveRecord::Base
  has_and_belongs_to_many :topics, join_table: :speakers_topics
end
