class ModifyFunkisTimeslots < ActiveRecord::Migration[5.0]
  def change
    remove_column :funkis_timeslots, :time
    change_table :funkis_timeslots do |t|
      t.timestamp :start_time
      t.timestamp :end_time
    end
  end
end
