class FunkisApplication < ApplicationRecord
  belongs_to :funkis
  belongs_to :first_post,
          class_name: 'Funkis_Category', inverse_of: nil,
          foreign_key: 'first_post'

  belongs_to :second_post,
          class_name: 'Funkis_Category', inverse_of: nil,
          foreign_key: 'second_post'

  belongs_to :third_post,
          class_name: 'Funkis Category', inverse_of: nil,
          foreign_key: 'third_post'
end
