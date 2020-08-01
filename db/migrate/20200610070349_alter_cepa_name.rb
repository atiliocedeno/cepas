class AlterCepaName < ActiveRecord::Migration[5.2]
  def change
    add_index :cepas, :name, unique: true
  end
end
