class UsersController < ApplicationController
  include ApplicationHelper

  before_action :check_can_delete

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to timetrackers_path, :notice => "#{@user.name} and timetrackers successfully removed"
    else
      flash[:error] = "Could not remove #{@user.name}: #{@user.errors}"
      redirect_to user_times_path(@user)
    end
  end

  private

  def check_can_delete
    redirect_to root_url unless can_delete_user?
  end

end
