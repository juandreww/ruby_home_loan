class ProfileController < ApplicationController
  def download
    send_data(Prawn::Document.new)
  end

  def show
    @user = User.find_by! id: params[:id]
  end

  def edit
  end

  def update
  end

  private
end
