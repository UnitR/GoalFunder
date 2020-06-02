class ApplicationController < ActionController::Base
  # before_action :authenticate_user!

  # Specify how to handle NotAuthorized
  # rescue_from User::NotAuthorized, with: :user_not_authorized

  private

  # The user is trying to do something illegal so stop them nicely.
  def user_not_authorized
    # Show the user a friendly error message and redirect
    flash[:error] = "You don't have access to this section."
    redirect_back(fallback_location: root_path)
  end

#adds new params to devise user-------------------------------------------------
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :encrypted_password, :is_admin, :is_organisation]) << :invited_by
    end
end
