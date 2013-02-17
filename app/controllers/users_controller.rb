class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.haml
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to request.referer, notice: 'Your settings were successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
