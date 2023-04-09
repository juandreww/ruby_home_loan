class CheckoutController < ApplicationController
  def create
    product = Product.find_by(id: params[:id])

    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: product.name,
        amount: product.price.to_i,
        currency: "sgd",
        quantity: 1
      }],
      mode: 'payment',
      success_url: 'https://example.com/success',
      cancel_url: 'https://example.com/cancel',
    })

    respond_to do |format|
      format.js
    end
  end
end