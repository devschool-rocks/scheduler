require 'calendar'

class CalendarController < ApplicationController

  def show
    calendar
    agenda
  end

private

  def the_date
    params[:date]||Date.today
  end

  def calendar
    @calendar ||= Calendar::Calendar.new(the_date)
  end

  def agenda
    @agenda ||= Calendar::Agenda.new(
      date: DateTime.parse(the_date.to_s),
      start_hour: 10,
      end_hour: 20
    )
  end
end
