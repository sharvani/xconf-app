class RemoveTopicRegistererIdFromUsers < ActiveRecord::Migration

  def self.up
    remove_column :users, :topic_registerer_id
  end

  def self.down
    add_column :users, :topic_registerer_id, :integer
  end

end
