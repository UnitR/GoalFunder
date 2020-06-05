class Photo < ApplicationRecord

  # ==========================
  # RELATIONSHIPS
  # ==========================
  belongs_to :user
  belongs_to :group
  belongs_to :goal

  # ==========================
  # VALIDATIONS
  # ==========================
  before_validation :check_owners

  # ==========================
  # Private Methods
  # ==========================
  private

  def check_owners

    # If no owner id is specified, log error for the model
    return unless !user_id && !group_id && !goal_id

    # No owner id specified, point to user
    errors.add(:user, 'Owner must be specified.')

  end

end
