class AddAttributesToFamorg < ActiveRecord::Migration[5.0]
  def change
    add_column :famorgs, :santas_assigned, :boolean, null: false, default: false
    add_column :famorgs, :date, :date
    add_column :famorgs, :cost, :decimal, precision: 5, scale: 2
  end
end
