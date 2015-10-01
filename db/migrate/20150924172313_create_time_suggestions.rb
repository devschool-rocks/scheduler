class CreateTimeSuggestions < ActiveRecord::Migration
  def change
    create_table :time_suggestions do |t|
      t.references :suggester, polymorphic: true, index: true
      t.references :appointment, index: true, foreign_key: true
      t.timestamp :start_at, null: false
      t.timestamp :accepted_at

      t.timestamps null: false
    end
  end
end
