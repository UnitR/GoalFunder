class User < ApplicationRecord

  # ==========================
  # RELATIONSHIPS
  # ==========================
  has_many :goal_owners
  has_many :goals, through: :goal_owners
  has_many :groups
  has_many :user_group_memberships
  has_many :payments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
