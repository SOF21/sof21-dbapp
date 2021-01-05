class ModifyFunkisApplication < ActiveRecord::Migration[5.0]
  def change
    remove_column :funkis_applications, :first_day
    remove_column :funkis_applications, :second_day
    remove_column :funkis_applications, :third_day

    change_table :funkis_applications do |t|
      t.date :first_day
      t.date :second_day
      t.date :third_day
    end
  end
end
