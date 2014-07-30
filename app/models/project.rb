class Project < ActiveRecord::Base
	belongs_to :user
	has_many :shifts, dependent: :destroy
end
