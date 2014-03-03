class TeamReport < ActiveRecord::Base
  attr_accessible :content, :team_id

  #=====Associations=====
  belongs_to :team
end
