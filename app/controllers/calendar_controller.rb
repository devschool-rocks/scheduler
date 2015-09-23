require 'calendar'

class CalendarController < ApplicationController
  layout "calendar"

  def show
    calendar
  end

private

  def calendar
    @calendar ||= Calendar::HtmlCalendar.new(Date.today)
  end

end
