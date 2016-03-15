class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :password, :on => :create
	#before create {generate_token(:auth_token)}

	#def generate_token(column)
		#
	#end
end
