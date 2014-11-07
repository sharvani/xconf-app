class AddEmailToAdmin < ActiveRecord::Migration
  def change
    add_column :admin_users, :email, :string
  end
end
