class AddForeignKeyToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :musical_instrument, foreign_key: true
  end
end
