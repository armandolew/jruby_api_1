class User < ApplicationRecord

  has_many :events

  attr_accessor :password

  validates :name, presence: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :email, presence: true, on: :create
  validates :password, presence: true, on: :create
  validates :phone, presence: true, on: :create

  def generate_token
  	token = SecureRandom.hex
    self.token = token
  end

  def encrypt_password(password)
  	password_encrypted = BCrypt::Password.create(password)
  	self.password_encrypted = password_encrypted
  end
end
