class CreateDmRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :dm_rooms do |t|
      t.string :name, default: "", null: false

      t.timestamps
    end
  end
end
