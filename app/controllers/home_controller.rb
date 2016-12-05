class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:splash, :email_sent, :invite_users, :group_invite]



  def splash
  end

  def invite_users
    email = params[:email]
    first_name = params[:first_name]
    last_name = params[:last_name]
    def invitor(email, first_name, last_name)
      user = User.new
      user.email = email
      user.first_name = first_name
      user.last_name = last_name
      user.invite!
    end

    if User.find_by(email: email).present?
      redirect_to new_user_session_path, notice: 'Email already in use, please sign in.'
    else
      if email.present?
        invitor(email, first_name, last_name)
        redirect_to email_sent_path
      else
        redirect_to root_path, notice: 'You must enter an email address.'
      end

    end
  end

  def email_sent
  end

end
