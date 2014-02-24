class Report < ActiveRecord::Base
  attr_accessible :experience, :plan, :problem, :review, :solution, :status, :user_id, :report_date


  #====Associations=====
  belongs_to :user

  #=====Scopes=====
  scope :this_week,lambda{where(:report_date => ((Date.today.beginning_of_week)..(Date.today.end_of_week))) }

  #====Logic====

  def self.get_by_team(team_name)
    Report.joins(:user => :team).where('teams.name'=>team_name)
  end

  def self.get_by_date(date)
    where(report_date: date)
  end

end
