class User < ApplicationRecord

  has_many :goals, through: :goal_owners
  has_many :groups
  has_many :user_group_memberships

end
