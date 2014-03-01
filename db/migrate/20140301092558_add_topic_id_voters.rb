class AddTopicIdVoters < ActiveRecord::Migration

  def self.up
    add_column :voters, :topic_id, :integer
  end

  def self.down
    remove_column :voters, :topic_id
  end

end
