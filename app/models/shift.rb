class Shift < ActiveRecord::Base
	belongs_to :project

	validates :start_date, :presence => true
	validates :end_date, :presence => true
	validates_datetime :end_date, :after => :start_date


end
