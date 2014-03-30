require_relative '../../lib/report_file_generator/daily_report_excel.rb'

class ReportsController < ApplicationController

  authorize_resource :user
  authorize_resource :report
  def index
    @reports = current_user.reports.this_week.order(:report_date)

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
      @reports<<Report.create!(report_date: date,user_id: current_user.id,status: 'pending')
    end
    respond_to do |format|
      format.html do
        redirect_to user_reports_path(current_user.id)
      end
      format.js
    end
  end

  def new
    @report = Report.new
  end

  def update
    @report = Report.find(params[:id])
    @report.update_attributes!(params[:report])
    redirect_to user_reports_path(@report.user),notice: 'Report successfully updated'
  end

  def submit
    @report = Report.find(params[:id])
    @report.update_attributes(status: 'submitted')
    @noti = current_user.activities.create! action: 'submitted', trackable: @report
    respond_to do |format|
      format.html {    redirect_to user_reports_path(@report.user),notice: 'Report successfully submitted' }
      format.js
    end

  end

  def get_excel
    @report =  Report.find(params[:id])
    @reports = current_user.reports.this_week.order(:report_date)
    generator = ReportFileGenerator::DailyReportExcel.new(@reports)
    path = generator.generate_file_path(@report,"#{Rails.root}/storage/custom").to_excel

    send_file(path,type: "application/vnd.ms-excel")
  end

end
