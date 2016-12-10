class AddSantaToUserFamorg < ActiveRecord::Migration[5.0]
  def change
    add_column :user_famorgs, :santa_id, :integer
  end
end
