require 'rails_helper'

RSpec.describe HomeLoansController, type: :request do
  it 'should return valid calculation' do
    post '/home_loans/calculate', params: { amount: 10_000_000, term_in_years: 1, monthly_interest_rate: 10 }

    expect(response.status).to eql 302
    expect(session['flash']['flashes']).to eql({"notice"=>"Amount you have to pay per month is IDR 916,667.00"})
  end
end