class Brand < ApplicationRecord
  has_one :owner

  validates :name, presence: true
  validates :address, presence: true

  enum vision: { profit: 0, charity: 1, trial: 2 }
end
