class Admin::ProfileController < ApplicationController
  def download
    send_data(Prawn::Document.new)
  end

  def show
    @user = User.find_by(id: params[:id])

    if !@user
      redirect_to '/users/sign_in', notice: "Please login first"
      return
    end
  end

  def edit
  end

  def update
  end

  def page_title
    'Profile'
  end
end
