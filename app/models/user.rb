class User < ApplicationRecord

  # ==========================
  # RELATIONSHIPS
  # ==========================
  has_many :goal_owners
  has_many :goals, through: :goal_owners
  has_many :groups, through: :user_group_memberships
  has_many :user_group_memberships
  has_many :payments

  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
