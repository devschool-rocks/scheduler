class AddRejectedAtToTimeSuggestions < ActiveRecord::Migration
  def change
    add_column :time_suggestions, :rejected_at, :timestamp
  end
end
