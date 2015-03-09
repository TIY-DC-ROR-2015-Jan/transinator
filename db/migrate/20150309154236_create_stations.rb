class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :type
      t.string :api_id

      t.timestamps null: false
    end
  end
end
