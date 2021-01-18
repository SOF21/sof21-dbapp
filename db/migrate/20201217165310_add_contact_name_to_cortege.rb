class AddContactNameToCortege < ActiveRecord::Migration[5.0]
  def change
    add_column :corteges, :contact_name, :string, null: false, limit:40
  end
end
