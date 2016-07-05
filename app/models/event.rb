class Event < ApplicationRecord
  has_many :photos
  belongs_to :user

  validates :name, presence: true, on: :create
  validates :date, presence: true, on: :create
  validates :location, presence: true, on: :create
  validates :latitude, presence: true, on: :create
  validates :longitude, presence: true, on: :create


  def generate_token
    token = SecureRandom.hex
    self.token = token
  end
end
