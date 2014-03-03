class TeamReport < ActiveRecord::Base
  attr_accessible :content, :team_id, :report_date

  #=====Associations=====
  belongs_to :team
end
