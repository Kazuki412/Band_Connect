class CreateBands < ActiveRecord::Migration[6.1]
  def change
    create_table :bands do |t|
      t.string :name, default: "", null: false
      t.text :introduction, default: "", null: false
      t.boolean :band_status, default: true, null: false
      t.boolean :band_status2, default: true, null: false
      t.integer :owner_id, default: "", null: false

      t.timestamps
    end
  end
end
