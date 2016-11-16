class AdminmailMailer < ActionMailer::Base

  class MailNotSentException < Exception

  end

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

  def sending_mail(mail)
    @adminmail = mail
    if mail.file.present?
      attachments["#{mail.file_file_name}"] =  File.read(mail.file.path)
    end 
    mail(:from => mail.sender_mail, :to => mail.receiver_mail, :subject => mail.subject,:cc => mail.cc)
  end
 
end
