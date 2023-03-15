class User < ApplicationRecord
  include ActiveModel::Validations

  has_secure_password

  enum status: { activated: 0, deactivated: 1, verify: 2 }

  validates :email, email: true, uniqueness: { case_sensitive: false }
  validates :phone, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, format: { with: %r{\A[A-Za-z0-9-/.\s]+\z} }
  validates :name, format: { with: /[a-zA-Z0-9]/ }
  validates :user_uuid, presence: true

  validate :password_requirements_are_met

  def following
    FollowersUser.where(user_follower_id: id)
  end

  def followers
    FollowersUser.where(user_id: id)
  end

  def assign_status
    self.status = User.statuses[:verify] if status.nil?
  end

  def password_requirements_are_met
    rules = {
      ' must contain at least one lowercase letter' => /[a-z]+/,
      ' must contain at least one uppercase letter' => /[A-Z]+/,
      ' must contain at least one digit' => /\d+/,
      ' must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add(:password, message) unless password.match(regex)
    end
  end
end
