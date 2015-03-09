class AddLatAndLongtoUsers < ActiveRecord::Migration
  def change
    remove_column :users, :location
    add_column :users, :lat, :integer
    add_column :users, :long, :integer
  end
end
