class CreateWineCepas < ActiveRecord::Migration[5.2]
  def change
    create_table :wine_cepas do |t|
      t.references :wine, foreign_key: true
      t.references :cepa, foreign_key: true
      t.float :percentage

      t.timestamps
    end
  end
end
