class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :customer, index: true, foreign_key: true
      t.text :notes, null: false
      t.timestamp :completed_at

      t.timestamps null: false
    end
  end
end
