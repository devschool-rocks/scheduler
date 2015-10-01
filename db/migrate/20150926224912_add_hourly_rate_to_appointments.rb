class AddHourlyRateToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :hourly_rate, :integer
  end
end
