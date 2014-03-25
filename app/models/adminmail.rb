class Adminmail < ActiveRecord::Base

  attr_accessible :cc, :content, :date, :receiver_mail, :sender_mail, :sender_password, :subject,:file

  has_attached_file :file
end
