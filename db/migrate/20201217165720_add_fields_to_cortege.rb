class AddFieldsToCortege < ActiveRecord::Migration[5.0]
  def change
    add_column :corteges, :image_url, :string, null: false
    add_column :corteges, :theme_connection, :string, null: false
  end
end
