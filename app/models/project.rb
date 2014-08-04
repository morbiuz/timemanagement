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

	def total_time_textual
		seconds = total_time
		mm, ss = seconds.divmod(60)
		hh, mm = mm.divmod(60)
		dd, hh = hh.divmod(24)
		@textual_time = ""
		@textual_time += "#{dd} " + 'day'.pluralize(dd) + ' ' unless dd == 0
		@textual_time += "#{hh} " + 'hour'.pluralize(hh) + ' ' unless hh == 0
		@textual_time += "#{mm} " + 'minute'.pluralize(mm) + ' ' unless mm == 0
		@textual_time += "#{dd} " + 'second'.pluralize(ss) + ' ' unless ss == 0
		return @textual_time
	end

end
