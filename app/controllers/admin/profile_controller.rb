class Admin::ProfileController < ApplicationController
  def download
    send_data(Prawn::Document.new)
  end

  def show
    if !filtered_user
      redirect_to '/users/sign_in', notice: "Please login first"
      return
    end
  end

  def edit
    if !filtered_user
      redirect_to '/users/sign_in', notice: "Please login first"
      return
    end
  end

  def edit_password
    if !filtered_user
      redirect_to '/users/sign_in', notice: "Please login first"
      return
    end
  end

  def update_password
    if !filtered_user
      redirect_to '/users/sign_in', notice: "Please login first"
      return
    end

    user_and_password_matches = BCrypt::Password.new(filtered_user.password_digest) == update_password_params[:old_password]

    draft_user = filtered_user
    draft_user.password = update_password_params[:new_password]
    draft_user.password_requirements_are_met

    if draft_user.invalid?
      render :edit_password, status: :unprocessable_entity
      return
    end

    if user_and_password_matches
      draft_user.save!
      redirect_to "/profile/#{filtered_user.id}", notice: "Successfully changed password"
    else
      redirect_to "/profile/#{filtered_user.id}/edit_password", notice: "Password do not match"
      return
    end
  end

  def update
    if !filtered_user
      redirect_to '/users/sign_in', notice: "Please login first"
      return
    end

    draft_user = filtered_user
    draft_user.assign_attributes(update_params)

    if draft_user.invalid?
      render :edit, status: :unprocessable_entity
      return
    end

    draft_user.save!

    redirect_to "/admin/profile/#{draft_user.id}", notice: "Updated successfully"
  end

  def page_title
    'Profile'
  end

  def send_telegram
    text_message = "Andrew's PC just send you a message at #{(Time.zone.now + 7.hours).strftime(JAKARTA_DDMMYYHHMM)}"
    HTTParty.post("https://api.telegram.org/#{TELEGRAM_BOT}/sendMessage?chat_id=#{TELEGRAM_CHAT_ID_PRIVATE}&text=#{text_message}")

    redirect_to profile_path(params[:id]), notice: 'Message sent successfully'
  end

  private

  def filtered_user
    @user = User.find_by(id: params[:id])
  end

  def update_params
    update_params ||= params.require(:user).permit(:name, :image)
  end

  def update_password_params
    update_params ||= params.require(:user).permit(:old_password, :new_password)
  end
end
