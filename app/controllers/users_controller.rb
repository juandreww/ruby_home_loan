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
    @user.user_uuid = SecureRandom.uuid
    @user.password_digest = BCrypt::Password.create(params[:user][:password_digest])

    if @user.save
      redirect_to '/users/sign_in', notice: "Successfully created new User"
    else
      render :sign_up, status: :unprocessable_entity
    end
  end

  def new_session
    @user = User.find_by_email(new_session_params[:email])

    if @user.present? && BCrypt::Password.new(@user.password_digest) == new_session_params[:password_digest]
      redirect_to '/users/sign_in', notice: "Successfully started new session"
    else
      render :sign_in, status: :unprocessable_entity
    end
  end

  def forgot_password; end

  def page_title
    'User'
  end

  private

  def create_params
    create_params ||= params.require(:user).permit(:email, :name, :phone)

    create_params
  end

  def new_session_params
    new_session_params ||= params.require(:user).permit(:email, :password_digest)

    new_session_params
  end
end
