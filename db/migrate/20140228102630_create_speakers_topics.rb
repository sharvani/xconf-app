class CreateSpeakersTopics < ActiveRecord::Migration

  def self.up
    create_join_table :speakers, :topics do |t|
      t.references :speaker_id
      t.references :topic_id
      t.boolean :has_registered
      t.timestamps
    end
  end

  def self.down
    drop_table :speakers_topics
  end
end
