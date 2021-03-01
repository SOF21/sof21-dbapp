class ChangeFlagsInCorteges < ActiveRecord::Migration[5.0]
  def change
    change_column :corteges, :flags, :string, default: "00000"
  end
end
