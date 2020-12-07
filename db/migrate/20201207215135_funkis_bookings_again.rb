class FunkisBookingsAgain < ActiveRecord::Migration[5.0]
  #remove_column :funkis_timeslot, :funkis_id
  def change
    drop_table :funkis_booking

    create_table :funkis_bookings do |t|
      t.belongs_to :funkis
      t.belongs_to :funkis_timeslot
    end
  end
end
