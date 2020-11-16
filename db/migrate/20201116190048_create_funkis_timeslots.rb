class CreateFunkisTimeslots < ActiveRecord::Migration[5.0]
  def change
    create_table :funkis_timeslots do |t|
      t.datetime :time

      t.timestamps
    end
  end
end
