class Goal < ApplicationRecord
  has_one :goal_owner
  has_many :payments
end
