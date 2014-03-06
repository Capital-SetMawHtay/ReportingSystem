class Admin::ReportsController < ApplicationController
  load_and_authorize_resource :report
  def index
    @reports = @reports.get_by_date(Date.today).order(:report_date)
  end
end
