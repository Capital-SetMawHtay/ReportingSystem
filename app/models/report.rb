class Report < ActiveRecord::Base
  attr_accessible :experience, :plan, :problem, :review, :solution, :status, :user_id, :report_date


  #====Associations=====
  belongs_to :user
  has_one :report_file
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
    Time.new(2014,3,20,9,0)
  end

  def end_time
    Time.new(2014,3,20,17,30)
  end
  #to get the plan of previous report
  def plan_for_today
     previous_date = previous_day(report_date)
     previous_report = Report.find_by_report_date(previous_date)
     (previous_report.nil? || previous_report.blank?) ? 'nothing' : (previous_report.plan)
  end
  #the method asks if a report file is generated for this instance of report
  def generated?
    !report_file.nil?
  end

  def submittable?
    status == 'pending' && report_date <= Date.today
  end

  private
    # if the date is monday then previous is last friday else previous is yesterday
    def previous_day(date)
      if(Date.today.beginning_of_week === date) then
        previous = date-3
      else
        previous = date-1
      end
    end
end
