class AddIndices < ActiveRecord::Migration
  def change
    add_index :users, :email
    add_index :topics, :category_id
    add_index :voters_topics, :user_id
    add_index :voters_topics, :topic_id
    add_index :speakers_topics, :topic_id
    add_index :speakers_topics, :user_id
  end
end
