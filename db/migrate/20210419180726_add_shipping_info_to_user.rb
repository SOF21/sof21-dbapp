class AddShippingInfoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invoice_address, :string
    add_column :users, :phone, :string
    add_column :users, :allergies, :string
  end
end
