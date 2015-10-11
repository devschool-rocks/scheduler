class Appointment < ActiveRecord::Base
  belongs_to :customer
  has_many :time_suggestions, dependent: :destroy

  DEFAULT_RATE = 75

  PAYMENT_TYPES = {
    railsmentor: {
      rate: 20, label: '$20 every 15 minutes @ RailsMentor'
    },
    codementor: {
      rate: 25, label: '$25 every 15 minutes @ CodeMentor'
    },
    allotted: {
      rate: 0, label: 'Nada suckah! This is my allotted Devschool session'
    },
    alacarte: {
      rate: 10, label: '$15 every 15 minutes for additional Devschool tutoring'
    }
  }

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
    with_suggestions.
      where("time_suggestions.accepted_at IS NOT NULL")
  }

  scope :rejected, -> {
    with_suggestions.
      where("time_suggestions.rejected_at IS NOT NULL")
  }

  scope :unapproved, -> {
    current - current.approved
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
    Appointment.current.include?(self)
  end

  def approved?
    time_suggestions.last.accepted_at.present?
  end

  def unapproved?
    !approved?
  end

  def rejected?
    time_suggestions.last.rejected_at.present?
  end

  def archived?
    Appointment.archived.include?(self)
  end

  def status_css
    archived_css     || rejected_css ||
      unapproved_css || approved_css
  end

  %i[approved rejected unapproved archived].each do |m|
    define_method "#{m}_css" do
      m.to_s if send("#{m}?")
    end
  end

  def start_at=(val)
    time_suggestions.build(start_at: val)
  end

  def last_rejected_at
    time_suggestions.last.rejected_at
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
