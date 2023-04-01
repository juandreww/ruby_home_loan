class Admin::QrCodesController < ApplicationController
  def show
  end

  def generator
  end

  def download
    send_data RQRCode::QRCode.new(params[:content].to_s).as_png(size: 300), type: 'image/png', disposition: 'attachment'
  end

  def page_title
    'QR Codes'
  end
end
