class Blackout < ActiveRecord::Base
  belongs_to :instructor

  scope :current, -> {
    where("starts_at >= ?", DateTime.now)
  }

  scope :ordered, -> {
    order(starts_at: :asc)
  }

  scope :occuring_in, ->(date) {
    where("starts_at >= ? AND starts_at <= ?", date.beginning_of_month, date.end_of_month)
  }

end
