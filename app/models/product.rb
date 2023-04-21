class Product < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :images

  validates :name, :price, presence: true
  validates :avatar, attached: true,
                     content_type: 'image/png',
                     size: { less_than: 100.kilobytes ,
                             message: 'cannot exceed 100kb' },
                     aspect_ratio: :landscape

  def to_s
    name
  end
end
