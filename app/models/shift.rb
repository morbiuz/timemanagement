class Shift < ActiveRecord::Base
	belongs_to :project

	validates :start_date, :presence => true
	validates :end_date, :presence => true
	validates_datetime :end_date, :after => :start_date

	def to_s
		@text_duration = "From #{start_date.to_s(:long)} to #{end_date.to_s(:long)}"
		return @text_duration
	end
end
