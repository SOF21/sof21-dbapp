class FunkisBookings < ActiveRecord::Migration[5.0]
  #remove_column :funkis_timeslot, :funkis_id
  def change
    create_table :funkis_booking do |t|
      t.belongs_to :funkis
      t.belongs_to :funkis_timeslot
    end
  end
end
