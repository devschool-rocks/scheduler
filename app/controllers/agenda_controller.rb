class AgendaController < ApplicationController

  def show
    render json: { hours: agenda.to_a }
  end

private

  def the_date
    params[:id]||Date.today
  end

  def agenda
    @agenda ||= Calendar::Agenda.new(
      date: DateTime.parse(the_date.to_s),
      appointments: Appointment.occuring_on(the_date)
    )
  end
end
