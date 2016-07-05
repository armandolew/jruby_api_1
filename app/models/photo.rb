class Photo < ApplicationRecord
  belongs_to :event, dependent: :destroy

  validates :title, presence: true, on: :create
  validates :event_id, presence: true, on: :create
  validates :image, presence: true, on: :create
  validate :image_size_validation, on: :create

  mount_uploader :image, PhotoUploader

  private

    def image_size_validation
      return false if image.size > 5.megabytes
    end

end
