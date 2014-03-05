class AddTopicIdVoters < ActiveRecord::Migration

  def self.up
    create_table :voters do |t|
      t.timestamps
    end
    add_column :voters, :topic_id, :integer
  end

  def self.down
    remove_column :voters, :topic_id
    drop_table :voters
  end

end
