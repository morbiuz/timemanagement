class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.Date :startDate
      t.Date :endDate

      t.timestamps
    end
  end
end
