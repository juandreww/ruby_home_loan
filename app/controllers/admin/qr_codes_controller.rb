class Admin::QrCodesController < ApplicationController
  def show
  end

  def generator
  end

  def download
    qr_code = RQRCode::QRCode.new(params[:content].to_s)
    svg = RQRCode::Renderers::SVG.render(qr, level: :l, unit: 4)
    File.open("#{Rails.root}/public/qr_code.svg", 'w') do |file|
      file.write(svg)
    end

    redirect_to '/qr_codes/generator'
  end

  def page_title
    'QR Codes'
  end
end
