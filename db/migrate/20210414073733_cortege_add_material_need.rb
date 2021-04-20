class CortegeAddMaterialNeed < ActiveRecord::Migration[5.0]
  def change
    add_column :corteges, :material, :boolean, default: nil
  end
end
