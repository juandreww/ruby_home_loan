class CheckoutController < ApplicationController
  def create
    product = Product.find_by(id: params[:id])

    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [
        price_data: {
          unit_amount: product.price.to_i,
          currency: 'sgd',
          product_data: {
            name: product.name
          },
        },
        quantity: 1,
      ],
      mode: 'payment',
      success_url: 'https://example.com/success',
      cancel_url: 'https://example.com/cancel',
    })

    respond_to do |format|
      format.html do
        redirect_to '/checkout/pay'
      end
    end
  end

  def page_title
    'Checkout'
  end
end