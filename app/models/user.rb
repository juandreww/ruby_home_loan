class User < ApplicationRecord
  include ActiveModel::Validations

  has_secure_password

  validates :email, email: true
end
