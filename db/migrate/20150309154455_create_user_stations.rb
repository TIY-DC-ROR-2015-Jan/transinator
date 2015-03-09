class CreateUserStations < ActiveRecord::Migration
  def change
    create_table :user_stations do |t|
      t.belongs_to :user 
      t.belongs_to :station 
      t.timestamps null: false
    end
  end
end
