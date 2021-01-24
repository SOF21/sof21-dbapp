class Cortege < ApplicationRecord
  belongs_to :user
  has_many :cortege_memberships
  has_many :members, through: :cortege_memberships, source: :user

  after_initialize -> { self. flags.blank? ? self. flags.push('0') : self. flags }

  def has_owner?(owner)
    user == owner
  end

  def has_member?(member)
    members.include? member
  end

  def has_membership?(membership)
    cortege_memberships.include? membership
  end
end
