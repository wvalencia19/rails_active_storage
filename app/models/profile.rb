class Profile < ApplicationRecord
  has_one_attached :image

  validates :name, :description, presence: true

  scope :with_eager_loaded_image, -> { eager_load(image_attachment: :blob) }
  scope :with_preloaded_image, -> { preload(image_attachment: :blob) }
end
