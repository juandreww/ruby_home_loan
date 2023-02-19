class UsersController < ApplicationController
  def sign_up
    @user = User.new
  end

  def sign_in
    @user = User.new
  end

  def sign_up
    @user = User.new
    byebug
  end

  def create
    @user = User.new
  end

  def new_session
    byebug
    @user = User.new
  end

  def successful_sign_up
  end

  def forgot_password
  end

  def page_title
    'User'
  end

  def user_params

  end
end
