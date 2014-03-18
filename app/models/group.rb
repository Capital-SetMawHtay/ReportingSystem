class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :messages
end
