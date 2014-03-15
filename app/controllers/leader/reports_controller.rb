class Leader::ReportsController < ApplicationController
  append_before_filter :lock_out_non_leader
  authorize_resource :report
  def index
    @submitted_reports = Report.joins(:user => :team).where(:teams=>{:id => current_user.team_id}).submitted_today.order(:report_date)
    @reviewed_reports = Report.joins(:user => :team).where(:teams=>{:id => current_user.team_id}).reviewed_today.order(:report_date)
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    @report.update_review(params[:report])
    redirect_to leader_team_reports_path, notice: 'Report successfully reviewed'
  end

  private
     def lock_out_non_leader
       raise CanCan::AccessDenied unless current_user && current_user.leader?
       return
     end


end
