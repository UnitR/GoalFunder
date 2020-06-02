class RegistrationsController < Devise::RegistrationsController

  def new
    @token = params[:invite_token] #<-- pulls the value from the url query string
  end

  def create
    @newUser = build_user(user_params)
    @newUser.save
    @token = params[:invite_token]
    if @token != nil
      org =  Invite.find_by_token(@token).group #find the user group attached to the invite
      @newUser.groups.push(org) #add this user to the new user group as a member
    else
      # do normal registration things #
    end
  end

  protected

  def after_sign_up_path_for(resource)
  invite = Invite.find_by_email(resource.email)
  if invite
    invite.group.users << resource
    invite.destroy
  end
  after_sign_in_path_for(resource)
  end
end
