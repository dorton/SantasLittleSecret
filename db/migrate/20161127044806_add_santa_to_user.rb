class AddSantaToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :santa, :string
  end
end
