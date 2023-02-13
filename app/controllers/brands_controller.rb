class BrandsController < ApplicationController
  def new
    byebug
    @brand = Brand.new
    new_params['vision']
  end

  def create
    @brand = Brand.new(create_params)

    if @brand.save
      redirect_to @brand
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @brand = Brand.find_by(id: params['id'])
  end

  def page_title
    'Brand'
  end

  private

  def new_params
    params.permit(vision: [])
  end

  def create_params
    params['brand'].permit(:name, :address)
  end
end
