class TimetrackersController < ApplicationController
  before_action :set_timetracker, only: [:show, :edit, :update, :destroy, :toggle]

  def index
    @timetrackers = Timetracker.where(user: current_user)
  end

  def user_times
    @user = User.find(params[:id])
    @timetrackers = Timetracker.where(user: @user)
  end

  def toggle
    @timetracker.received = !@timetracker.received

    if @timetracker.save
      redirect(@timetracker.user, 'Successfully toggled received on Timetracker')
    else
      redirect(@timetracker.user, 'Could not toggle received on Timetracker', true)
    end
  end

  def receive_all
    @user = User.find(params[:id])
    @timetrackers = Timetracker.where(user: @user, received: false)

    success = true
    @timetrackers.each do |time|
      time.received = true
      success = time.save and success
    end

    if success
      redirect(@user, 'Successfully received all times')
    else
      redirect(@user, 'Receiving one or more times failed', true)
    end
  end

  def new
    @timetracker = Timetracker.new
  end

  def edit
  end

  def create
    @timetracker = Timetracker.new(timetracker_params)
    @timetracker.user = current_user

    if @timetracker.save
      redirect_to timetrackers_path, notice: 'Timetracker was successfully created.'
    else
      flash[:error] = @timetracker.errors
      render action: 'new'
    end
  end

  def update
    if @timetracker.update(timetracker_params)
      redirect_to timetrackers_path, notice: 'Timetracker was successfully updated.'
    else
      flash[:error] = @timetracker.errors
      render action: 'edit'
    end
  end

  def destroy
    @timetracker.destroy
    redirect_to timetrackers_url, notice: 'Timetracker was successfully destroyed.'
  end

  private

  def set_timetracker
    @timetracker = Timetracker.find(params[:timetracker_id] || params[:id])
  end

  def timetracker_params
    params.require(:timetracker).permit(:id, :date, :time, :user, :received, :description)
  end

  def redirect(user, notice, error=false)
    if error
      flash[:error] = notice
    else
      flash[:notice] = notice
    end

    if user == current_user
      redirect_to timetrackers_path
    else
      redirect_to user_times_path(user)
    end
  end
end
