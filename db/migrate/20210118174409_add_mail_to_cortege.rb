class AddMailToCortege < ActiveRecord::Migration[5.0]
  def change
    add_column :corteges, :contact_mail, :string
  end
end
