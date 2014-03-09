class CreateVotersTopics < ActiveRecord::Migration

  def self.up
    create_table :voters_topics do |t|
      t.references :user
      t.references :topic
      t.timestamps
    end
  end

  def self.down
    drop_table :voters_topics
  end
end
