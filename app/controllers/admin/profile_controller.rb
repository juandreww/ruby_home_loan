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
  end

  def page_title
    'Profile'
  end

  private

  def filtered_user
    @user = User.find_by(id: params[:id])
  end
end
