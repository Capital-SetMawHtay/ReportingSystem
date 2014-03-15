class Admin::ReportsController < ApplicationController
  append_before_filter :lock_out_non_admin
  load_and_authorize_resource :report
  def index
    @reports = @reports.get_by_date(Date.today).order(:report_date)
  end

  private
    def lock_out_non_admin
      raise CanCan::AccessDenied unless current_user.admin?
      return
    end
end
