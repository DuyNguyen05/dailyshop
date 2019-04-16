class User < ApplicationRecord
  before_save { email.downcase! }
  attr_accessor :remember_token
  validates :name , presence: true , length: {minimum: 5}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , uniqueness: true,
  format: {with: VALID_EMAIL_REGEX}

  has_secure_password
  validates :password ,length: {minimum: 8 , maximum: 20}, allow_nil: true
  validates :phone, uniqueness: true ,length: {minimum:8}, allow_nil: true
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def authenticated? remember_token
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

end
