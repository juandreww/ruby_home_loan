class UsersController < ApplicationController
  def sign_up
    byebug
  end

  def sign_in
    @user = User.new
  end

  def successful_sign_up
  end

  def forgot_password
  end

  def page_title
    'User'
  end
end
