class RemoveIdFromVotersTopics < ActiveRecord::Migration

  def self.up
    remove_column :voters_topics, :id
  end

  def self.down
    add_column :voters_topics, :id, :integer
  end

end
