class AlterWineName < ActiveRecord::Migration[5.2]
  def change
    add_index :wines, :name, unique: true
  end
end
