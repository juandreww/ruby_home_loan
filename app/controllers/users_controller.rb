class UsersController < ApplicationController
  def sign_up
    @user = User.new
  end

  def sign_in
    @user = User.new
  end

  def sign_up
    @user = User.new
  end

  def create
    @user = User.new(create_params)

    if @user.save
      redirect_to sign_up_path, notice: "Successfully created new User"
    else
      render :sign_up, status: :unprocessable_entity
    end
  end

  def new_session
    @user = User.new
  end

  def forgot_password; end

  def page_title
    'User'
  end

  def show
  end

  private

  def create_params
    create_params = params.permit(:email, :password)

    create_params ||= params.require(:user).permit(:email, :password)

    create_params
  end
end
