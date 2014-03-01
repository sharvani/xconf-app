class DropVoters < ActiveRecord::Migration

  def self.up
    drop_table :voters
  end

  def self.down
    create_table :voters do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
