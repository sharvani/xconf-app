class CreateTalkFormat < ActiveRecord::Migration
  def change
    create_table :talk_formats do |t|
      t.string :name, null: false
      t.integer :time, null: false
    end
  end
end
