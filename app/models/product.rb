class Product < ApplicationRecord
  has_one_attached :avatar

  validates :name, :price, presence: true

  def to_s
    name
  end
end
