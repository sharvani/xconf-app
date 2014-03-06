class AddDurationToTopic < ActiveRecord::Migration

  def self.up
    add_column :topics, :duration, :integer
  end

  def self.down
    remove_column :topics, :duration
  end

end
