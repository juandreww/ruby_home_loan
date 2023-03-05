require 'rails_helper'

RSpec.describe HomeLoansController, type: :request do
  it 'should return valid calculation' do
    post '/home_loans/calculate', params: { amount: 10_000_000, term_in_years: 1, monthly_interest_rate: 10 }
    payload = JSON.parse(response.body)
    byebug
    expect(response.status).to eql 200
    expect(payload['message']).to eql('An activation code would be sent to your phone number!')
    expect(payload['phone']).to eql user.phone.to_s
  end
end