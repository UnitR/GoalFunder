class User < ApplicationRecord

  has_many :goals, through: :goal_owners

end
