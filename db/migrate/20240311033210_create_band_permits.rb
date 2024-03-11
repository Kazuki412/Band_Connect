class CreateBandPermits < ActiveRecord::Migration[6.1]
  def change
    create_table :band_permits do |t|
      t.references :user, null: false, foreign_key: true
      t.references :band, null: false, foreign_key: true

      t.timestamps
    end
  end
end
