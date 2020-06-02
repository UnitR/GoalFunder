class Invite < ApplicationRecord
  belongs_to :group
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.group_id, Time.now, rand].join)
  end

  before_save :check_user_existence

  def check_user_existence
    recipient = User.find_by_email(email)
    if recipient
      self.recipient_id = recipient.id
    end
  end

  def create
  @invite = Invite.new(invite_params)
  @invite.sender_id = current_user.id
  if @invite.save

    #if the user already exists
    if @invite.recipient != nil

      #send a notification email
      InviteMailer.existing_user_invite(@invite).deliver

      #Add the user to the user group
      @invite.recipient.groups.push(@invite.group)
    else
      InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
    end
  else
    # oh no, creating an new invitation failed
  end
  end
end