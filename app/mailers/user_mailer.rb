class UserMailer < ApplicationMailer
 
  def issue_update_email(user, issue)
    @user = user
    @issue = issue
    mail(to: @user.email, from: "#{ENV['GMAIL_ADDRESS']}", subject: 'an issue has been updated on GitHub')
  end
end
