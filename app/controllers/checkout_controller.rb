class CheckoutController < ApplicationController
  def create
    product = Product.find_by(id: params[:id])
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

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

  def pay
    current_user = User.first

    @checkout_session = current_user.payment_processor.checkout(
      mode: 'subscription',
      line_items: 'price_1MwaLNJWXdSisGNL3IPri5f3'
    )
    byebug
    partial_html = render_to_string(partial: 'pay/stripe/checkout_button', locals: { session: @checkout_session, title: "Checkout" })
    render json: { partial_html: partial_html }
  end

  def page_title
    'Checkout'
  end
end