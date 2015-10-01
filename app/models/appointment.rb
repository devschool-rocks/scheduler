class Appointment < ActiveRecord::Base
  belongs_to :customer
  has_many :time_suggestions, dependent: :destroy

  DEFAULT_RATE = 100

  scope :occuring_on, -> (day) {
    with_suggestions.
      where("DATE(time_suggestions.start_at) = ?", day)
  }

  scope :current, -> {
    with_suggestions.
      where("time_suggestions.start_at >= ?", DateTime.now.utc)
  }

  scope :approved, -> {
    with_suggestions.approved
  }

  scope :with_suggestions, -> {
    joins("LEFT JOIN time_suggestions ON
           time_suggestions.appointment_id = appointments.id").
           distinct
  }

  def approved?
    time_suggestions.approved.any?
  end

  def status_css
    approved? ? "approved" : "unapproved"
  end

  def start_at=(val)
    time_suggestions.build(start_at: val)
  end

  def start_at
    suggestion = time_suggestions.last
    suggestion && suggestion.start_at
  end
end
