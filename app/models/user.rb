class User < ActiveRecord::Base
	has_many :projects, dependent: :destroy
	has_many :shifts, through: :projects
	
	#attr_accessible :username, :email, :password, :password_confirmation

	attr_accessor :password
	EMAIL_REGEX = /\A\S+@.+\.\S+\z/

	#only validate when user is created through register form
	with_options :if => "provider.nil?" do |regular_user|
		regular_user.validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
		regular_user.validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
		regular_user.validates :password, :confirmation => true #password_confirmation attr
		regular_user.validates_length_of :password, :in => 6..20, :on => :create
	end

	before_save :encrypt_password
	after_save :clear_password


	def self.create_with_omniauth(auth)
		User.create!(
			:provider => auth['provider'],
			:uid => auth['uid'],
			:name => auth['info']['name'])
	end

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def clear_password
		self.password = nil
	end

	def self.authenticate(user_or_email="", login_password="")
		if EMAIL_REGEX.match(user_or_email)
			user = User.find_by_email(user_or_email)
			puts "USER FOUND: #{user.name}"
		else
			user = User.find_by_name(user_or_email)
		end
		if user && user.match_password(login_password)
			return user
		else
			return false
		end
	end

	def match_password(login_password="")
		encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
	end
	
end
