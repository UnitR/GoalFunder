class UserGroupMembership < ApplicationRecord

  # ==========================
  # RELATIONSHIPS
  # ==========================
  belongs_to :user
  belongs_to :group

end
