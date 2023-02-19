class User < ApplicationRecord
  include ActiveModel::Validations

  has_secure_password

  validates :email_attributes, email: true
end
