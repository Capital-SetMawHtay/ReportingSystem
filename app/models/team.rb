class Team < ActiveRecord::Base
  attr_accessible :name

  #=====Associations====
  has_many :users
  has_many :team_reports

  #=======Validations=====

  validates :name,presence: true
end
