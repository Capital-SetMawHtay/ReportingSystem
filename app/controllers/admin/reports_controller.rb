class Admin::ReportsController < ApplicationController
  append_before_filter :lock_out_non_admin
  authorize_resource :report
  def index
    @reports = Report.get_by_date(Date.today).order(:report_date).group_by{|r|r.user.team.name}
  end

  private
    def lock_out_non_admin
      raise CanCan::AccessDenied unless current_user.admin?
      return
    end
end
