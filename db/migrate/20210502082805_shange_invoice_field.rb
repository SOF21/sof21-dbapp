class ShangeInvoiceField < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :invoice_address, :pick_up_point
  end
end
