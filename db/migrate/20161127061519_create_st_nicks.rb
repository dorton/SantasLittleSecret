class CreateStNicks < ActiveRecord::Migration[5.0]
  def change
    create_table :st_nicks do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
