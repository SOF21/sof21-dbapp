class OrchestraAddInvoiceAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :orchestras, :invoice_address, :string, default: nil, null: true
  end
end
