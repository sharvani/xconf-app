class ChangeVotersTopicsColumnsToNullFalse < ActiveRecord::Migration

  def self.up
    change_column :voters_topics, :topic_id, :integer, null: false
    change_column :voters_topics, :user_id, :integer, null: false
  end

  def self.down
    change_column :voters_topics, :user_id, :integer
    change_column :voters_topics, :topic_id, :integer
  end
end
