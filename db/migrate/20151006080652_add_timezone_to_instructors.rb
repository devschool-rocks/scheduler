class AddTimezoneToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :timezone, :string
  end
end
