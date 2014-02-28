class AddVotesToTopic < ActiveRecord::Migration

  def self.up
    add_column :topics, :votes, :integer, default: 0
  end

  def self.down
    remove_column :topics, :votes
  end

end
