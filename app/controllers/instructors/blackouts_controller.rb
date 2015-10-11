class Instructors::BlackoutsController < Instructors::ApplicationController

  def index
    @blackouts = current_instructor.blackouts.ordered
  end

  def new
    @blackout = current_instructor.blackouts.new
  end

  def create
    times_to_local_time
    @blackout = current_instructor.blackouts.new(blackout_params)
    if @blackout.save
      redirect_to :instructors_blackouts
    else
      render :new
    end
  end

private

  def times_to_local_time
    Time.zone = current_instructor.timezone
    blackout_params[:starts_at] = Time.zone.parse(blackout_params[:starts_at])
    blackout_params[:ends_at]   = Time.zone.parse(blackout_params[:ends_at])
  end

  def blackout_params
    params.require(:blackout).permit(:starts_at, :ends_at)
  end

end
