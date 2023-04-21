class Product < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :images

  validates :name, :price, presence: true
  validates :avatar, attached: true, content_type: 'image/png'

  def to_s
    name
  end
end
