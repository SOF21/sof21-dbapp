class FunkisApplication < ApplicationRecord
  belongs_to :funkis
  has_one :first_post,
          class_name: 'Funkis_Category',
          foreign_key: 'first_post'

  has_one :sec_post,
          class_name: 'Funkis_Category',
          foreign_key: 'sec_post'

  has_one :third_post,
          class_name: 'Funkis Category',
          foreign_key: 'third_post'
end
