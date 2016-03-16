class User < ActiveRecord::Base
  attr_accessor :remember_token
	has_secure_password
	validates_presence_of :password, :on => :create
  validates :password, length: {minimum: 8}
  validates :first_name, :last_name, presence: true

   def forget
    update_attribute(:remember_digest, nil)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
