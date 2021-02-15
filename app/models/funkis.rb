class Funkis < ApplicationRecord
  has_one :funkis_application, class_name: :FunkisApplication
  has_one :funkis_category
  has_many :funkis_bookings
  has_many :funkis_timeslots, through: :funkis_bookings
end