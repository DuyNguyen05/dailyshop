class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name , presence: true , length: {minimum: 5}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , uniqueness: true,
  format: {with: VALID_EMAIL_REGEX}

  has_secure_password
  validates :password ,length: {minimum: 8 , maximum: 20}, allow_nil: true
  validates :phone, uniqueness: true ,length: {minimum:8}, allow_nil: true


  def digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def new_token
    SecureRandom.urlsafe_base64
  end
end
