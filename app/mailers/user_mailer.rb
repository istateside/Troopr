class UserMailer < ActionMailer::Base
  default from: "Kevin Fleischman <admin@troopr.com>"
  
  def auth_email(user)
    @user = user
    @user.activation_token = SecureRandom::urlsafe_base64(16).to_s
    @user.save
    @url = '/users/activate?activation_token=' + @user.activation_token
    mail(to: user.email, subject: "Welcome to Troopr!")
  end
end
