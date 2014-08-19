class AddDurationToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :duration, :decimal
  end
end
