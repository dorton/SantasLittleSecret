# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def assigned_notification
    UserMailer.assigned_notification(Famorg.last, User.find(2))
  end
end
