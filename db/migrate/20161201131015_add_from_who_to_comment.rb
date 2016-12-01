class AddFromWhoToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :writer, :string
    add_column :comments, :reader, :string
  end
end
