class BrandsController < ApplicationController
  def new
    @brands = Brand.new
  end
end
