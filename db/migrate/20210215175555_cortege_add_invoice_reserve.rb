class CortegeAddInvoiceReserve < ActiveRecord::Migration[5.0]
  def change
    add_column :corteges, :invoice_address, :string
    add_column :corteges, :secondary_name, :string
    add_column :corteges, :secondary_mail, :string
    add_column :corteges, :secondary_phone, :string

  end
end
