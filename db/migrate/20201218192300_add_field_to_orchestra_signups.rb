class AddFieldToOrchsetraSignups < ActiveRecord::Migration[5.0]
  def change
    add_column :orchestra_signups, :pickup_with, :boolean
  end
end
