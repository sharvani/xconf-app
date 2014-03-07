class RemoveDurationFromTopic < ActiveRecord::Migration

  def self.up
    remove_column :topics, :duration
  end

  def self.down
    add_column :topics, :duration, :integer
  end

end
