class ChangeDefaultOfOrchestraSIgnups < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orchestra_signups, :pickup_with, false
  end
end
