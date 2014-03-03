class RemoveHasRegisteredFromSpeakersTopics < ActiveRecord::Migration

  def self.up
    remove_column :speakers_topics, :has_registered
  end

  def self.down
    add_column :speakers_topics, :has_registered, :boolean
  end
end
