class SetDefaultValueHasRegistered < ActiveRecord::Migration

  def self.up
    change_column :speakers_topics, :has_registered, :boolean, :default => false
  end

  def self.down
    remove_column :speakers_topics, :has_registered
    remove_column :speakers_topics, :has_registered, :boolean
  end

end
