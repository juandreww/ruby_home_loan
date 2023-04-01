class Admin::QrCodesController < ApplicationController
  def show
  end

  def generator
    @has_svg = File.exists?("public/qr_code.svg")
  end

  def download
    qr_code = RQRCode::QRCode.new(params[:content].to_s)
    svg = qr_code.as_svg( color: "000", shape_rendering: "crispEdges", module_size:11,
      standalone: true,
      use_path: true
    )

    File.open("#{Rails.root}/app/assets/images/qr_code.svg", 'w') do |file|
      file.write(svg)
    end

    redirect_to '/qr_codes/generator'
  end

  def page_title
    'QR Codes'
  end
end
