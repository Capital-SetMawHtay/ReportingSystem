class Team < ActiveRecord::Base
  attr_accessible :name

  #=====Associations====
  has_many :users

  validates :name,presence: true
end
