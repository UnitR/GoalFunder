class Group < ApplicationRecord

  # ==========================
  # RELATIONSHIPS
  # ==========================
  belongs_to :user
  has_many :users, through: :user_group_membership

end
