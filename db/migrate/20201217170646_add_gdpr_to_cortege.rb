class AddGdprToCortege < ActiveRecord::Migration[5.0]
  def change
    add_column :corteges, :gdpr, :boolean, default: false
    remove_column :corteges, :comments, :string
  end
end
