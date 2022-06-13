class Picture < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 20 }
end
