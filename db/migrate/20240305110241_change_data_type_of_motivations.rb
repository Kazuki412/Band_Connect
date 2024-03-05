class ChangeDataTypeOfMotivations < ActiveRecord::Migration[6.1]
  def change
    change_column :motivations, :name, :string
  end
end
