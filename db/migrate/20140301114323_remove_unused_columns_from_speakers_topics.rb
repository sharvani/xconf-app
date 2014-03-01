class RemoveUnusedColumnsFromSpeakersTopics < ActiveRecord::Migration

  def self.up
    remove_column :speakers_topics, :speaker_id_id
    remove_column :speakers_topics, :topic_id_id
  end

  def self.down
    add_column :speakers_topics, :speaker_id_id, :integer
    add_column :speakers_topics, :topic_id_id, :integer
  end
end
