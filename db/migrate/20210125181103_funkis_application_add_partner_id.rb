class FunkisApplicationAddPartnerId < ActiveRecord::Migration[5.0]
  def change
    add_column :funkis_applications, :parnter_id, :string
  end
end
