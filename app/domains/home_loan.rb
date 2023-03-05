require 'prawn'

class HomeLoan
  include Prawn::View

  def initialize
  end

  def build
    pdf = Prawn::Document.new

    pdf.text "Test Title", align: :center
    pdf.text "Address"
    pdf.text "Email"
  end
end