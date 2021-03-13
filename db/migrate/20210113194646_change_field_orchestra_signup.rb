class ChangeFieldOrchestraSignup < ActiveRecord::Migration[5.0]
  def change
    change_column :orchestra_signups, :pickup_with, 'boolean USING CAST(pickup_with AS boolean)'
  end
end
