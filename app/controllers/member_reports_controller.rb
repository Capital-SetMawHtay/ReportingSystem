class MemberReportsController < ApplicationController
  def index
    @reports = Report.this_week.where(:user_id=> current_user).order(:report_date)

  end

  def show
    @report = Report.find(params[:id])
  end

  def edit
    @report = Report.find(params[:id])
  end

  def create
    @reports = []
    first = Date.today.beginning_of_week
    last = Date.today.beginning_of_week+4
    (first..last).each do |date|
      @reports<<Report.create!(report_date: date,user_id: current_user.id)
    end
    respond_to do |format|
      format.html do
        redirect_to member_reports_path
      end
      format.js
    end
  end

  def new
    @report = Report.new
  end

  def update
    @report = Report.find(params[:id])
    @report.update_attributes(params[:report])
    redirect_to reports_path,notice: 'Report successfully updated'
  end
end
