class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
	  t.belongs_to :project
      t.date :startDate
      t.date :endDate

      t.timestamps
    end
  end
end
