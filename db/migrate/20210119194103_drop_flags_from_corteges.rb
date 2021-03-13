class DropFlagsFromCorteges < ActiveRecord::Migration[5.0]
  def change
    add_column :corteges, :flags, :text, default: [], array: true
  end
end
