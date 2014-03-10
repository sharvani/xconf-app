class RemoveTopicIdFormUsers < ActiveRecord::Migration

  def self.up
    remove_column :users, :topic_id
  end

  def self.down
    add_column :users, :topic_id, :integer
  end

end
