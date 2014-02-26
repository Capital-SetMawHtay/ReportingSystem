class TeamReportsController < ApplicationController
  # GET /team_reports
  # GET /team_reports.json
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

  # GET /team_reports/new
  # GET /team_reports/new.json
  def new
    @team_report = TeamReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team_report }
    end
  end

  # GET /team_reports/1/edit
  def edit
    @team_report = TeamReport.find(params[:id])
  end

  # POST /team_reports
  # POST /team_reports.json
  def create
    @team_report = TeamReport.new(params[:team_report])

    respond_to do |format|
      if @team_report.save
        format.html { redirect_to @team_report, notice: 'Team report was successfully created.' }
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
    @team_report = TeamReport.find(params[:id])

    respond_to do |format|
      if @team_report.update_attributes(params[:team_report])
        format.html { redirect_to @team_report, notice: 'Team report was successfully updated.' }
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
    @team_report = TeamReport.find(params[:id])
    @team_report.destroy

    respond_to do |format|
      format.html { redirect_to team_reports_url }
      format.json { head :no_content }
    end
  end
end
