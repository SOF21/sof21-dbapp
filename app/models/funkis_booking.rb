class FunkisBooking < ApplicationRecord
  belongs_to :funkis
  belongs_to :funkis_timeslot
end
