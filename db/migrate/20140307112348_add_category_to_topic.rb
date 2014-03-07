class AddCategoryToTopic < ActiveRecord::Migration

  def self.up
    add_column :topics, :category, :string
  end

  def self.down
    remove_column :topics, :category
  end

end
