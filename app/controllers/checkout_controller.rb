class UsersController < ApplicationController
  def create
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [
        price_data: {
          product: '{{PRODUCT_ID}}',
          unit_amount: 1500,
          currency: 'sgd',
        },
        quantity: 1,
      ],
      mode: 'payment',
      success_url: 'https://example.com/success',
      cancel_url: 'https://example.com/cancel',
    })
  end
end