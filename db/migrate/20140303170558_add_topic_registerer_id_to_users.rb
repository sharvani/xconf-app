class AddTopicRegistererIdToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :topic_registerer_id, :integer
  end

  def self.down
    remove_column :users, :topic_registerer_id
  end

end
