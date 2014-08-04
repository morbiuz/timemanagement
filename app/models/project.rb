class Project < ActiveRecord::Base
	belongs_to :user
	has_many :shifts, dependent: :destroy

	validates :name, :presence => true
	validates :user_id, :presence => true

	def total_time

		@total_time = 0
		@project_shifts = Shift.where("project_id = ?",id)
		@project_shifts.each do |shift|
			puts shift.end_date.to_s
			puts shift.start_date.to_s
			@total_time += shift.end_date - shift.start_date
		end
		return @total_time

	end
end
