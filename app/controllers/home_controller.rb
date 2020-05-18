class HomeController < ApplicationController
  def index
  end

  def contact
  end

  def sign_up
  end

  def log_in
  end

  def show_fundraisers
  end

  def show_groups
  end

  def show_goals
  end

  def about
  end

  def contact
  end

  def whatever_view_this_is
  @home_banner  = true
end

  def request_contact
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]

    if email.blank?
      flash[:alert] = I18n.t('home.request_contact.no_email')
    else
      # Send an email
      flash[:notice] = I18n.t('home.request_contact.email_sent')
    end
    redirect_to root_path
  end
end
