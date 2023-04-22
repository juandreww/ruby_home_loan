class Product < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :images

  validates :name, :price, presence: true
  validates :avatar, attached: true,
                     content_type: [:png, :jpg, :jpeg],
                     size: { less_than: 1.megabytes ,
                             message: 'cannot exceed 1MB' }
  validates :images, attached: true, limit: { min: 1, max: 3 },
                     content_type: [:png, :jpg, :jpeg]

  def to_s
    name
  end
end
