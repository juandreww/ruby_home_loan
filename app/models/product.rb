class Product < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :images

  validates :name, :price, presence: true

  def to_s
    name
  end
end
