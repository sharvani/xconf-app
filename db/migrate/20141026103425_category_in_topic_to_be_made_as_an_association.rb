class CategoryInTopicToBeMadeAsAnAssociation < ActiveRecord::Migration
  def change
    remove_column :topics, :category, :string
    add_column :topics, :category_id, :integer
  end
end
