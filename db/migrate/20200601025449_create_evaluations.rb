class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.references :wine, foreign_key: true
      t.references :oenologist, foreign_key: true
      t.float :rank

      t.timestamps
    end
  end
end
