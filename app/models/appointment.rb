class Appointment < ActiveRecord::Base
  belongs_to :customer
  has_many :time_suggestions, dependent: :destroy

  DEFAULT_RATE = 75

  scope :occuring_on, -> (day) {
    with_suggestions.
      where("DATE(time_suggestions.start_at) = ?", day)
  }

  scope :current, -> {
    with_suggestions.
      where("time_suggestions.start_at >= ?", DateTime.now.utc).
      ordered
  }

  scope :approved, -> {
    current.where("time_suggestions.accepted_at IS NOT NULL")
  }

  scope :unapproved, -> {
    current - approved
  }

  scope :archived, -> {
    with_suggestions.
      where("time_suggestions.accepted_at IS NOT NULL AND
             time_suggestions.start_at < NOW()")
  }

  scope :ordered, -> {
    with_suggestions.
    order("max(time_suggestions.start_at) ASC").
    group("appointments.id, time_suggestions.id")
  }

  scope :with_suggestions, -> {
    joins(:time_suggestions).
      includes(:time_suggestions)

  }

  def current?
    self.class.current.include?(self)
  end

  def approved?
    time_suggestions.approved.any?
  end

  def status_css
    approved? ? "approved" : "unapproved"
  end

  def start_at=(val)
    time_suggestions.build(start_at: val)
  end

  def suggested_start_at
    suggestion = time_suggestions.last
    suggestion && suggestion.start_at
  end
  alias_method :start_at, :suggested_start_at

  def approved_start_at
    appointment = time_suggestions.approved.first
    appointment && appointment.start_at
  end
end
