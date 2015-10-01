class AppointmentsController < ApplicationController
  before_action :authenticate_instructor!, only: [:index]
  before_action :authenticate_customer!, only: [:create]

  def index
    @appointments = Appointment.current
  end

  def create
    new_appointment.save
    render json: new_appointment.to_json
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
