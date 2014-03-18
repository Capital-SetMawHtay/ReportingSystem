class GroupsController < ApplicationController

  def index
    @groups = Group.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @group = Group.find(params[:id])

  end

  def create
    @group = Group.new(params[:group])
    @group.users<<current_user
    @group.save
    respond_to do |format|
      format.html
      format.js
    end
  end
  def update
    @group = Group.find(params[:id])
    @group.update_attributes(params[:group])
    respond_to do |format|
      format.html
      format.js
    end
  end
  def update_users
    @group = Group.find(params[:id])
    user_list = params[:user_ids]
    @group.update_attributes({:user_list => user_list.to_sentence(words_connector: ',',last_word_connector: ',',two_words_connector: ',')})
    respond_to do |format|
      format.html
      format.js
    end
  end
end
