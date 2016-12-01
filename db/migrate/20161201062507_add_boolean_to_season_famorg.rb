class AddBooleanToSeasonFamorg < ActiveRecord::Migration[5.0]
  def change
    add_column :season_famorgs, :santas_assigned, :boolean, null: false, default: false
  end
end
