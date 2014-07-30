class User < ActiveRecord::Base
	has_many :projects, dependent: :destroy
	has_many :shifts, through: :projects
	
	
	
end
