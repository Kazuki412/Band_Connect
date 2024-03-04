class AddMultipleColumnsToModels < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :motivation, foreign_key: true
    add_reference :bands, :genre, foreign_key: true
  end
end
