class TeamReportsController < ApplicationController
  # GET /team_reports
  # GET /team_reports.json
  # People who say it can not be done, should not interrupt those who are doing it.
  #George Bernhard Shaw
  load_and_authorize_resource :team
  load_and_authorize_resource :team_report,:through => :team


  def index
    @team_reports = TeamReport.accessible_by(current_ability)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @team_reports }
    end
  end

  # GET /team_reports/1
  # GET /team_reports/1.json
  def show
    #@team_report = TeamReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team_report }
    end
  end

  # GET /team_reports/new
  # GET /team_reports/new.json
  def new
    #@team_report = TeamReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team_report }
    end
  end

  # GET /team_reports/1/edit
  def edit
    #@team_report = TeamReport.find(params[:id])
  end

  # POST /team_reports
  # POST /team_reports.json
  def create
    #@team_report = TeamReport.new(params[:team_report])

    respond_to do |format|
      if @team_report.save
        format.html { redirect_to team_team_report_path(@team,@team_report), notice: 'Team report was successfully created.' }
        format.json { render json: @team_report, status: :created, location: @team_report }
      else
        format.html { render action: "new" }
        format.json { render json: @team_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /team_reports/1
  # PUT /team_reports/1.json
  def update
    #@team_report = TeamReport.find(params[:id])

    respond_to do |format|
      if @team_report.update_attributes(params[:team_report])
        format.html { redirect_to team_team_report_path(:team_id => @team.id,:id => @team_report.id), notice: 'Team report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_reports/1
  # DELETE /team_reports/1.json
  def destroy
    #@team_report = TeamReport.find(params[:id])
    @team_report.destroy

    respond_to do |format|
      format.html { redirect_to action: :index }
      format.json { head :no_content }
    end
  end
end
