class RenameSpeakerIdToUserId < ActiveRecord::Migration

  def self.up
    rename_column :speakers_topics, :speaker_id, :user_id
  end

  def self.down
    rename_column :speakers_topics, :user_id, :speaker_id
  end
end
