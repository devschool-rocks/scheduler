require 'active_support/core_ext/date'
require 'active_support/core_ext/time'
require 'active_support/core_ext/array'

require 'calendar/day_styles'
require 'calendar/weeks'

module Calendar
  class HtmlCalendar
    attr_reader :month, :year

    def initialize(date=Date.today)
      @date = date
      @month = Date::MONTHNAMES[date.month]
      @year = date.year
    end

    def to_a
      calendar_weeks.to_a.map do |week|
        week.map do |date|
          [date, day_styles(date)]
        end
      end
    end

  private

    #def events_for_date(date)
    #  @events.select {|e| e.ocurrs_on == date }
    #end

    def day_styles(date)
      DayStyles.new(date).to_s
    end

    def calendar_weeks
      @calendar_weeks ||= Calendar::Weeks.new(@date)
    end
  end
end

