# Preview all emails at http://localhost:3000/rails/mailers/product_mailer
class ProductMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/product_mailer/product_created
  def product_created
    ProductMailer.product_created
  end

  def product_updated
    ProductMailer.with(product: Product.first).product_updated
  end

end
