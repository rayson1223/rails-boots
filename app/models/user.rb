class User < ActiveRecord::Base
	attr_accessor :login
	belongs_to :role, :foreign_key => 'role_name'
	before_create :set_default_role

  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
      	   :recoverable, :rememberable, :trackable, :validatable

    validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

	def set_default_role
    	self.role ||= Role.find_by(name: 'user')
  	end

	def self.find_first_by_auth_conditions(warden_conditions)
  		conditions = warden_conditions.dup
  		if login = conditions.delete(:login)
    		where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
  		else
  	 	 	where(conditions).first
  		end
	end


end
