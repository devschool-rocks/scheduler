class TimeSuggestion < ActiveRecord::Base
  belongs_to :suggester, polymorphic: true
  belongs_to :appointment

  scope :approved, -> {
    where("accepted_at IS NOT NULL")
  }
end
