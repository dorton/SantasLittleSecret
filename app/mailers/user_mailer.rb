class UserMailer < ApplicationMailer
  default from: 'dorton@gmail.com'

  def assigned_notification(famorg, user)
    @famorg = famorg
    @user = user
    @santa_id = UserFamorg.find_by(famorg_id: @famorg.id, user_id: @user.id).santa_id
    @santa = User.find(@santa_id)
    @url  = 'http://secretsantapp.dorton.co/'
    mail(to: @user.email, subject: "Congrats! You're A Secret Santa!")
  end
end
