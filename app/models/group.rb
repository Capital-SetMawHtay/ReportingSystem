class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :messages
  belongs_to :owner,foreign_key: :owner_id,class_name: 'User',inverse_of: :owned_groups
end
