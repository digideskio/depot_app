class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  VALID_IMAGE_URL = %r{\.(gif|jpg|png)\Z}i
  validates :image_url, allow_blank: true, format: {
    with: VALID_IMAGE_URL,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
