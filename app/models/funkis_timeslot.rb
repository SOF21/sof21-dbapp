class FunkisTimeslot < ApplicationRecord
  belongs_to :funkis_category
  has_many :funkis_bookings
  has_many :funkis, through: :funkis_bookings
end
