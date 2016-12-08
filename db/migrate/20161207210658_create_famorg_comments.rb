class CreateFamorgComments < ActiveRecord::Migration[5.0]
  def change
    create_table :famorg_comments do |t|
      t.references :famorg, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
