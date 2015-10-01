require 'JSON'

module Calendar
  class Agenda
    def initialize(date: Date.today,
                   start_hour: 15,
                   end_hour: 23,
                   appointments: [])

      @date         = date
      @date_time    = DateTime.parse(date.to_s)
      @start_hour   = start_hour
      @end_hour     = end_hour
      @appointments = appointments
    end

    def to_a
      (start_hour..end_hour).map do |h|
        start_at = (date_time+h.hours)
        {
          start_at: start_at,
          status: bookable_status(start_at)
        }
      end
    end

  private

    attr_reader :date,       :date_time,
                :start_hour, :end_hour,
                :appointments

    def bookable?(start_at)
      appointments.select {|a|
        a.start_at && a.start_at.utc == start_at.utc
      }.none? && start_at > DateTime.now
    end

    def bookable_status(start_at)
        bookable?(start_at) ? "available" :
                              "unavailable"
    end
  end
end
