class ProfileController < ApplicationController
  def download
    send_data(Prawn::Document.new)
  end

  def show
    
  end

  def edit
  end

  def update
  end
end
