class FunkisTimeslotRemoveFunkisId < ActiveRecord::Migration[5.0]
  remove_column :funkis_timeslots, :funkis_id
end
