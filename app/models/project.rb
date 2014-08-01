class Project < ActiveRecord::Base
	belongs_to :user
	has_many :shifts, dependent: :destroy

	validates :name, :presence => true
	validates :user_id, :presence => true
end
