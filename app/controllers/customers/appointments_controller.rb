class Customers::AppointmentsController < Customers::ApplicationController

  def index
    @appointments = current_customer.appointments
  end

  def create
    new_appointment.save
    send_emails(new_appointment)
    redirect_to :customers_appointments
  end

  def show
    @appointment = current_customer.appointments.find(params[:id])
  end

private

  def new_appointment
    @appointment ||= current_customer.appointments.build(appointment_params).tap do |a|
      a.instructor = Instructor.first
      a.time_suggestions.build(start_at: appointment_params[:start_at])
    end
  end

  def send_emails(appointment)
    RequestMailer.notify_customer(appointment).deliver
    RequestMailer.notify_instructor(appointment).deliver
  end

  def appointment_params
    params.require(:appointment).
           permit(:notes, :start_at, :payment_type)
  end
end
