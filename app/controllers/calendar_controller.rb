require 'calendar'

class CalendarController < ApplicationController

  def show
    calendar
    agenda
  end

private

  def the_date
    if params[:next_month]
      Date.today.end_of_month + 1.day
    else
      Date.today
    end
  end

  def calendar
    @calendar ||= Calendar::Calendar.new(the_date)
  end

  def agenda
    @agenda ||= Calendar::Agenda.new(
      date: DateTime.parse(the_date.to_s),
      start_hour: 15,
      end_hour: 23,
      appointments: Appointment.occuring_on(the_date)
    )
  end
end
