class Shift < ActiveRecord::Base
	belongs_to :project

	validates :start_date, :presence => true
	validates :end_date, :presence => true
	validates_datetime :end_date, :after => :start_date

	before_save :calc_duration

	def to_s
		@text_duration = "From #{start_date.to_s(:long)} to #{end_date.to_s(:long)} (#{duration.to_s} seconds)"
		return @text_duration
	end

	def calc_duration
		self.duration = ((end_date - start_date).round)/3600
	end

end
