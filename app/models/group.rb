class Group < ApplicationRecord

  # ==========================
  # RELATIONSHIPS
  # ==========================
  belongs_to :user, :optional => true
  belongs_to :name
  has_many :user_group_memberships
  has_many :users, through: :user_group_memberships
  has_many :goal_owners
  has_many :goals, through: :goal_owners

end
