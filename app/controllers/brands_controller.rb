class BrandsController < ApplicationController
  def new
    @brand = Brand.new
    new_instance_variables
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

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def new_instance_variables
    @vision = new_params['vision'].map { |vision| vision.to_i }
  end

  def new_params
    params.permit(vision: [])
  end

  def create_params
    params['brand'].permit(:name, :address)
  end
end
