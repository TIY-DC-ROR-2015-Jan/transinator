class AddBikeColumnstoStation < ActiveRecord::Migration
  def change
    add_column :stations, :terminalName, :integer
    add_column :stations, :lat, :string
    add_column :stations, :long, :string
    add_column :stations, :bikes, :integer
    add_column :stations, :empty, :integer
    add_column :stations, :name, :string
  end
end
