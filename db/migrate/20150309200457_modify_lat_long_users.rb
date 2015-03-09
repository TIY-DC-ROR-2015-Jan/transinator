class ModifyLatLongUsers < ActiveRecord::Migration
  def change
    change_column :users, :lat, :string
    change_column :users, :long, :string
  end
end
