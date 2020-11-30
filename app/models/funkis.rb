class Funkis < ApplicationRecord
  has_one :funkis_application
  has_one :funkis_category
  has_many :funkis_timeslot
end
