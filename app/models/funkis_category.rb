class FunkisCategory < ApplicationRecord
  has_many :funkis_timeslots
  has_many :funkis
end
