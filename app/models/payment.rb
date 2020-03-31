class Payment < ApplicationRecord

  # ==========================
  # RELATIONSHIPS
  # ==========================
  belongs_to :user
  belongs_to :goal

end
