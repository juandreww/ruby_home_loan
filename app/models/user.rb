class User < ApplicationRecord
  include ActiveModel::Validations

  has_secure_password

  validates :email, email: true
  validates :name, :password_digest, :phone, :user_uuid, presence: true
end
