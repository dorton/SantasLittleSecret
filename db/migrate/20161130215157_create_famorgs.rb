class CreateFamorgs < ActiveRecord::Migration[5.0]
  def change
    create_table :famorgs do |t|
      t.string :name

      t.timestamps
    end
  end
end
