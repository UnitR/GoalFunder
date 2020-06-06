class Goal < ApplicationRecord
  has_one :goal_owner, dependent: :delete
  has_many :payments, dependent: :delete_all

  after_initialize :init

  private

  def init
    self.target ||= 0.0
  end

end
