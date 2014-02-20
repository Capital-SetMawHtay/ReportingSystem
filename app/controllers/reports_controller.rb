class ReportsController < ApplicationController
  load_and_authorize_resource :report

  def index
    @reports = Report.get_by_date(Date.today)
  end

  def show
     @report = Report.find(params[:id])
  end

  def edit
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def update

  end

end
