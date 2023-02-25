class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sign_up
    @user = User.new
  end

  def sign_in
    @user = User.find_by(user_uuid: session[:user_uuid])

    if @user.present?
      redirect_to '/users/sign_up', notice: "Logged in as #{@user.name}"
      return
    end

    @user = User.new
  end

  def sign_up
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    @user.user_uuid = SecureRandom.uuid
    @user.otp = SecureRandom.alphanumeric(8).upcase
    @user.assign_status

    if @user.save
      send_otp_code(@user)
      redirect_to '/users/sign_in', notice: "Successfully created new user. OTP has been sent for verification"
    else
      render :sign_up, status: :unprocessable_entity
    end
  end

  def new_session
    @user = User.find_by_email(new_session_params[:email])

    if @user.present? && BCrypt::Password.new(@user.password_digest) == new_session_params[:password_digest]
      session['user_uuid'] = @user.user_uuid
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

  def send_otp_code(user)
    response = VerificationService.new(
      @user.name,
      @user.phone,
      @user.otp.to_s
    ).send_otp_code

    return response
  end

  def create_params
    create_params ||= params.require(:user).permit(:email, :name, :password, :phone)

    create_params
  end

  def new_session_params
    new_session_params ||= params.require(:user).permit(:email, :password_digest)

    new_session_params
  end

  # def send_otp_params
  #   send_otp_params ||= params.require(:user).permit(:phone)

  #   send_otp_params
  # end
end
