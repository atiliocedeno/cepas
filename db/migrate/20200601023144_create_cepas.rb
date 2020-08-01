class CreateCepas < ActiveRecord::Migration[5.2]
  def change
    create_table :cepas do |t|
      t.string :name

      t.timestamps
    end
  end
end
