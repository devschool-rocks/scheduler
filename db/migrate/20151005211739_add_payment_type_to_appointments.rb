class AddPaymentTypeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :payment_type, :string
  end
end
