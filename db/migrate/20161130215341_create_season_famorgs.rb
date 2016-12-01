class CreateSeasonFamorgs < ActiveRecord::Migration[5.0]
  def change
    create_table :season_famorgs do |t|
      t.references :season, foreign_key: true
      t.references :famorg, foreign_key: true

      t.timestamps
    end
  end
end
