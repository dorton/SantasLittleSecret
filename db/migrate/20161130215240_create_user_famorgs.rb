class CreateUserFamorgs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_famorgs do |t|
      t.references :user, foreign_key: true
      t.references :famorg, foreign_key: true

      t.timestamps
    end
  end
end
