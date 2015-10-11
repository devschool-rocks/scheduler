module Calendar
  class DayStyles
    def initialize(date: Date.today)
      @date = date
    end

    def to_s
      [past, today, future, other_month].compact.join(" ")
    end

  private

    def past
      "past" if @date < Date.today
    end

    def today
      "today" if @date == Date.today
    end

    def future
      "future" if @date > Date.today
    end

    def other_month
      "other-month" if @date.month != Date.today.month
    end
  end
end
