class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  attr_accessible :action, :trackable

  #scope
  scope :today,lambda{where("created_at > ?",DateTime.now - 1)}

end
