class Instructors::AppointmentsController < Instructors::ApplicationController

  def index
    @appointments = Appointment.all
  end

end
