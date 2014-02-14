class TeamsController < ApplicationController
  def index
    @teams = Team.all
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      respond_to do|format|
        format.js
      end
    end
  end
end
