class Drop17Funkis < ActiveRecord::Migration[5.0]
  def change
    drop_table :active_funkis_shift_limits
    drop_table :funkis_applications
    drop_table :funkis_categories
    drop_table :funkis_shift_applications
    drop_table :funkis_shifts
  end
end
