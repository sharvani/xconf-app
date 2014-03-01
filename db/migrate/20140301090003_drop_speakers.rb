class DropSpeakers < ActiveRecord::Migration

  def self.up
    drop_table :speakers
  end

  def self.down
    create_table :speakers do |t|
      t.string :name
      t.timestamps
    end
  end
end
