class TeamsController < ApplicationController
  def index
    @teams = Team.all
    @team = Team.new
    @teams = Team.paginate(:page=>params[:page],:per_page=>5)

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def create
    @team = Team.new(params[:team])
    respond_to do |format|
      if @team.save
        format.html { redirect_to(@team,notice: 'Team successfully created')}
        format.js
      else
        format.html { render action: "new"}
      end
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    respond_to do|format|
      format.html { redirect_to(teams_url)}
      format.js
    end
  end

  def edit
    @team = Team.find(params[:id])
    respond_to do|format|
      format.html
      format.js
    end
  end

  def update
    @team = Team.find(params[:id])
    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to(@team)}
        format.js
      else
        format.html { render action: "edit"}
      end
    end
  end


end
