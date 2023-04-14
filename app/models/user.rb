class User < ApplicationRecord
  include ActiveModel::Validations

  has_secure_password
  pay_customer
  pay_customer default_payment_processor: :stripe

  # mount_uploader :image, ImageUploader
  enum status: { activated: 0, deactivated: 1, verify: 2 }

  validates :email, email: true, uniqueness: { case_sensitive: false }
  validates :phone, uniqueness: { case_sensitive: false }
  validates :name, format: { with: /[a-zA-Z0-9]/ }
  validates :user_uuid, presence: true

  validate :password_requirements_are_met, on: :create

  has_one_attached :image

  # attribute :image_url, default: image
  # after_update :scale_image

  # def scale_image
  #   resized_image = MiniMagick::Image.read(image.download)
  #   resized_image.resize('300x300!')
  #   image.attach(
  #     io: File.open(resized_image.path),
  #     filename: image.filename,
  #     content_type: image.content_type)
  # end

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
