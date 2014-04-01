class Team < ActiveRecord::Base
  attr_accessible :name

  #=====Associations====
  has_many :users
  has_many :team_reports

  #=======Validations=====

  validates :name,presence: true


  def get_leader
    return User.get_admin if name == 'admin'
    u=users.detect do|u|
      u.leader? == true
    end
    u
  end
end
