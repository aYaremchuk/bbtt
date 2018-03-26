class NewPostNotificationMailer < ApplicationMailer
  def notification(post, user)
    @post = post
    @user = user
    mail(to: @user.email, subject: 'New post notification')
  end
end
