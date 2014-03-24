require_relative '../../../lib/report_file_generator/daily_report_excel.rb'

class Admin::ReportFilesController < ApplicationController
  # GET /report_files
  # GET /report_files.json
  def index
    @report_files = ReportFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @report_files }
    end
  end

  # GET /report_files/1
  # GET /report_files/1.json
  def show
    @report_file = ReportFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report_file }
    end
  end

  # GET /report_files/new
  # GET /report_files/new.json
  def new
    @report_file = ReportFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report_file }
    end
  end

  # GET /report_files/1/edit
  def edit
    @report_file = ReportFile.find(params[:id])
  end

  # POST /report_files
  # POST /report_files.json
  def create
    @report_file = ReportFile.new(params[:report_file])
    @report = @report_file.report
    @reports_for_week = Report.where(user_id: @report.user_id).this_week.order(:report_date)
    generator = ReportFileGenerator::DailyReportExcel.new(@reports_for_week)
    @report_file.file_path = generator.generate_file_path(@report,"#{Rails.root}/storage").to_excel
    respond_to do |format|
      if @report_file.save
        format.html { redirect_to @report_file, notice: 'Report file was successfully created.' }
        format.json { render json: @report_file, status: :created, location: @report_file }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @report_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /report_files/1
  # PUT /report_files/1.json
  def update
    @report_file = ReportFile.find(params[:id])

    respond_to do |format|
      if @report_file.update_attributes(params[:report_file])
        format.html { redirect_to @report_file, notice: 'Report file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_files/1
  # DELETE /report_files/1.json
  def destroy
    @report_file = ReportFile.find(params[:id])
    @report_file.destroy

    respond_to do |format|
      format.html { redirect_to report_files_url }
      format.json { head :no_content }
    end
  end
end
