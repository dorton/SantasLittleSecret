class AddBooleanToUserFamorg < ActiveRecord::Migration[5.0]
  def change
    add_column :user_famorgs, :admin, :boolean, null: false, default: false
  end
end
