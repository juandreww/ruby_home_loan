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

  def update
    if !filtered_user
      redirect_to '/users/sign_in', notice: "Please login first"
      return
    end

    draft_user = filtered_user
    draft_user.assign_attributes(update_params)

    if draft_user.errors.any?
      render :edit, status: :unprocessable_entity
      return
    end

    draft_user.save!

    redirect_to "/admin/profile/#{draft_user.id}", notice: "Updated successfully"
  end

  def page_title
    'Profile'
  end

  private

  def filtered_user
    @user = User.find_by(id: params[:id])
  end

  def update_params
    update_params ||= params.require(:user).permit(:name)
  end
end
