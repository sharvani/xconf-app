class AddRegistererIdToTopics < ActiveRecord::Migration

  def self.up
    add_column :topics , :registerer_id, :integer
  end

  def self.down
    remove_column :topics, :registerer_id
  end

end
