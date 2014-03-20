class Report < ActiveRecord::Base
  attr_accessible :experience, :plan, :problem, :review, :solution, :status, :user_id, :report_date


  #====Associations=====
  belongs_to :user

  #=====Scopes=====
  scope :this_week,lambda{where(:report_date => ((Date.today.beginning_of_week)..(Date.today.end_of_week))) }
  scope :today, lambda { where(report_date: Date.today)}
  scope :submitted, lambda {where(status: 'submitted')}
  scope :reviewed, lambda {where(status: 'reviewed')}
  scope :submitted_today,lambda { submitted.today }
  scope :reviewed_today,lambda { reviewed.today }
  #====Logic====
  def team
    user.team
  end
  def self.get_by_team(team_name)
    joins(:user => :team).where('teams.name'=>team_name)
  end

  def update_review(review)
    review = review.merge({status: 'reviewed'})
    update_attributes(review)
  end

  def self.get_by_date(date)
    where(report_date: date)
  end

  def start_time
    DateTime.new(2007, 12, 4, 9, 0, 0, 0)
  end

  def end_time
    DateTime.new(2014,12,4,17,30,0,0)
  end
end
