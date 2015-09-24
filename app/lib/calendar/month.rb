module Calendar
  class Month
    def initialize(date=Date.today)
      @date = date
    end

    def first_calendar_day
      @date.beginning_of_month.beginning_of_week(:sunday)
    end

    def last_calendar_day
      @date.end_of_month.end_of_week(:sunday)
    end
  end
end
