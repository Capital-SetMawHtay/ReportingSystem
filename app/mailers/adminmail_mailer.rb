class AdminmailMailer < ActionMailer::Base

	def init_email_account(sender_mail)  
      ActionMailer::Base.raise_delivery_errors = true
      ActionMailer::Base.smtp_settings = {
          :address                =>"smtp.gmail.com",
          :port                   => 587,
          :domain                 => "sendingmail.gmail.com",
          :user_name              => sender_mail.sender_mail,
          :password               => sender_mail.sender_password,
          :authentication         => "plain",
          :enable_starttls_auto   => true
      }
  end

  def sending_mail(user)
    @adminmail = user
    attachments["rails.png"] = File.read("#{Rails.root}/app/assets/images/rails.png")
    mail(:from => user.sender_mail, :to => user.receiver_mail, :subject => user.subject,:cc => user.cc)
  end
 
end
