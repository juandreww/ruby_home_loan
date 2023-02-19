class User < ApplicationRecord
  include ActiveModel::Validations

  has_secure_password

  validates :email, email: true, uniqueness: { case_sensitive: false }
  validates :phone, uniqueness: { case_sensitive: false }
  validates :name, format: { with: /[a-zA-Z0-9]/}
  validates :password_digest, :user_uuid, presence: true
end
