class RemoveVotesFromTopics < ActiveRecord::Migration

  def self.up
    remove_column :topics, :votes
  end

  def self.down
    add_column :topics, :votes, :integer
  end
end
