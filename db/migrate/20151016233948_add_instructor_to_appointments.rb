class AddInstructorToAppointments < ActiveRecord::Migration
  def change
    add_reference :appointments, :instructor, index: true, foreign_key: true
  end
end
