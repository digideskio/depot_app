class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { minimum: 6 }
  VALID_IMAGE_URL = %r{\.(gif|jpg|png)\Z}i
  validates :image_url, allow_blank: true, format: {
    with: VALID_IMAGE_URL,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  
  def self.latest
    Product.order(:updated_at).last
  end
  
  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, 'Line Items present')
      false
    end
  end
end
