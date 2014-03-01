class AddTopicIdToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :topic_id, :integer
  end

  def self.down
    remove_column :users, :topic_id
  end

end
