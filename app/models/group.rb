class Group < ApplicationRecord

  # ==========================
  # RELATIONSHIPS
  # ==========================
  belongs_to :user
  has_many :users, through: :user_group_membership
  has_many :goals, through: :goal_owners

end
