class ReportsController < ApplicationController
  load_and_authorize_resource :report

  def index
    if current_user.admin? then
      @reports = Report.get_by_date(Date.today)
    elsif current_user.member? then
      @reports = Report.this_week.where(:user_id=> current_user)
    else
      @reports = Report.all
    end
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
        redirect_to reports_path
      end
      format.js
    end
  end

  def new
    @report = Report.new
  end

  def update

  end

end
