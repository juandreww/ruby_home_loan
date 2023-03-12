class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sign_up
    @user = User.new
  end

  def sign_in
    @user = User.find_by(user_uuid: session[:user_uuid])

    if @user.present?
      redirect_to '/home_loans/new', notice: "Logged in as #{@user.name}"
      return
    else
      @user = User.new
    end
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

    user_and_password_matches = @user.present? && BCrypt::Password.new(@user.password_digest) == new_session_params[:password_digest]

    if user_and_password_matches && @user.verify?
      redirect_to "/users/verification?id=#{@user.id}", notice: "Please verify your account"
    elsif user_and_password_matches
      session['user_uuid'] = @user.user_uuid
      redirect_to '/users/sign_in', notice: "Successfully started new session"
    else
      @user = User.new if @user.nil?
      render :sign_in, status: :unprocessable_entity
    end
  end

  def verification
    @user = User.find_by(id: params[:id])

    if !@user
      render :sign_in, status: :unprocessable_entity
      return
    elsif @user.status == 'activated'
      render :sign_in, notice: "Logged in as #{@user.name}"
      return
    end
  end

  def verify
    @user = User.find_by(id: params[:id])

    unless @user
      render :sign_in, status: :unprocessable_entity
      return
    end

    if @user.otp == verify_params[:otp]
      @user.update!(status: User.statuses[:activated])
    else
      @user.errors.add(:otp, message: " field: Wrong OTP")

      render :verification, status: :unprocessable_entity
      return
    end

    render 'sign_in', notice: "Logged in as #{@user.name}"
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

  def verify_params
    verify_params ||= params.require(:user).permit(:otp)

    verify_params
  end
end
