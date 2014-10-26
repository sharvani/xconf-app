class RenameTalkFormatAndTimeToTimeInMinIn < ActiveRecord::Migration
  def change
    rename_table :talk_formats, :categories
    rename_column :categories, :time, :time_in_min
  end
end
