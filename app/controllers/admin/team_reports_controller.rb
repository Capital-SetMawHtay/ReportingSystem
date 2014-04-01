class Admin::TeamReportsController < ApplicationController
    # GET /team_reports
    # GET /team_reports.json
    before_filter :lock_out_non_admin


    def index
      @team_reports = TeamReport.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @team_reports }
      end
    end

    # GET /team_reports/1
    # GET /team_reports/1.json
    def show
      @team_report = TeamReport.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @team_report }
      end
    end


  private
    def lock_out_non_admin
      raise CanCan::AccessDenied unless current_user.admin?
    end

end
