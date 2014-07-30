class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
	  t.belongs_to :project
      t.Date :startDate
      t.Date :endDate

      t.timestamps
    end
  end
end
