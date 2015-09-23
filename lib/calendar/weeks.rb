require 'calendar/month'

module Calendar
  class Weeks
    delegate :first_calendar_day, :last_calendar_day,
      to: :calendar_month

    def initialize(date=Date.today)
      @date = date
    end

    def to_a
      (first_calendar_day..last_calendar_day).to_a.in_groups_of(7)
    end

    private

    def calendar_month
      @calendar_month ||= Month.new(@date)
    end

  end
end
