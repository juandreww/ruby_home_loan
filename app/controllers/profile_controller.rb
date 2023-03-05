class ProfileController < ApplicationController
  def download
    send_data(Prawn::Document.new)
  end
end
