class AdminmailsController < ApplicationController
  authorize_resource :adminmail
  # GET /adminmails
  # GET /adminmails.json
  def index
    @adminmails = Adminmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adminmails }
    end
  end

  # GET /adminmails/1
  # GET /adminmails/1.json
  def show
    @adminmail = Adminmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adminmail }
    end
  end

  # GET /adminmails/new
  # GET /adminmails/new.json
  def new
    @adminmail = Adminmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adminmail }
    end
  end

  # GET /adminmails/1/edit
  def edit
    @adminmail = Adminmail.find(params[:id])
  end

  # POST /adminmails
  # POST /adminmails.json
  def create
    @adminmail = Adminmail.new(params[:adminmail])

    require "timeout"
    begin
      status = Timeout::timeout(5){
        AdminmailMailer.init_email_account(@adminmail)
      }
    rescue Timeout::Error
      puts 'Please send again.'
    end

    AdminmailMailer.sending_mail(@adminmail).deliver


    respond_to do |format|
      if @adminmail.save
        format.html { redirect_to @adminmail, notice: 'Adminmail was successfully created.' }
        format.json { render json: @adminmail, status: :created, location: @adminmail }
      else
        format.html { render action: "new" }
        format.json { render json: @adminmail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adminmails/1
  # PUT /adminmails/1.json
  def update
    @adminmail = Adminmail.find(params[:id])

    respond_to do |format|
      if @adminmail.update_attributes(params[:adminmail])
        format.html { redirect_to @adminmail, notice: 'Adminmail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @adminmail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adminmails/1
  # DELETE /adminmails/1.json
  def destroy
    @adminmail = Adminmail.find(params[:id])
    @adminmail.destroy

    respond_to do |format|
      format.html { redirect_to adminmails_url }
      format.json { head :no_content }
    end
  end
end
