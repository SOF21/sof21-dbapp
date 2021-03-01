class FunkisApplication < ApplicationRecord
  belongs_to :funkis, class_name: :Funkis
  belongs_to :user, optional: true
  belongs_to :first_post,
          class_name: :FunkisCategory, inverse_of: nil,
          foreign_key: 'first_post_id'

  belongs_to :second_post,
          class_name: :FunkisCategory, inverse_of: nil,
          foreign_key: 'second_post_id'

  belongs_to :third_post,
          class_name: :FunkisCategory, inverse_of: nil,
          foreign_key: 'third_post_id'
end
