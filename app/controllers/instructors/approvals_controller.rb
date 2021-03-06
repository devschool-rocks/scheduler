class Instructors::ApprovalsController < Instructors::ApplicationController

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @appointment.time_suggestions.last.update_attributes(accepted_at: DateTime.now)
    notify_accept(@appointment)
    redirect_to :instructor_root
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.time_suggestions.last.update_attributes(rejected_at: DateTime.now)
    notify_reject(@appointment)
    redirect_to :instructor_root
  end

private

  def notify_accept(appointment)
    AcceptMailer.notify_customer(appointment).deliver
  end

  def notify_reject(appointment)
    RejectMailer.notify_customer(appointment).deliver
  end
end
