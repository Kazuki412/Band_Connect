class CreateMusicalInstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :musical_instruments do |t|
      t.string :name

      t.timestamps
    end
  end
end
