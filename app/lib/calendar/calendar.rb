module Calendar
  class Calendar
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

    attr_reader :appointments

    def appointments_for_date(date)
      appointments.select {|e| e.starts_at.to_date == date }
    end

    def day_styles(date)
      DayStyles.new(date).to_s
    end

    def calendar_weeks
      @calendar_weeks ||= Weeks.new(@date)
    end
  end
end
