class Customers::AppointmentsController < Customers::ApplicationController

  def index
    @appointments = current_customer.appointments
  end

  def create
    new_appointment.save
    redirect_to :customers_appointments
  end

  def show
    @appointment = current_customer.appointments.find(params[:id])
  end

private

  def new_appointment
    @appointment ||= current_customer.appointments.build(appointment_params).tap do |a|
      a.time_suggestions.build(start_at: appointment_params[:start_at])
    end
  end

  def appointment_params
    params.require(:appointment).
           permit(:notes, :start_at)
  end
end
