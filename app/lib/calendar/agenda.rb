module Calendar
  class Agenda
    def initialize(date: Date.today, start_hour: 9, end_hour: 17)
      @date = date
      @date_time = DateTime.parse(date.to_s)
      @start_hour = start_hour
      @end_hour   = end_hour
    end

    def to_a
      (start_hour..end_hour).map do |h|
        [
          (date_time+h.hours).strftime("%l %P").strip,
          'available',
          date_time.strftime("%F")
        ]
      end
    end

  private

    attr_reader :date,       :date_time,
                :start_hour, :end_hour
  end
end
