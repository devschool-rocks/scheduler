class Instructors::ApprovalsController < Instructors::ApplicationController

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @appointment.time_suggestions.last.update_attributes(accepted_at: DateTime.now)
    redirect_to :instructor_root
  end

end
