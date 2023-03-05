require 'rails_helper'

RSpec.describe HomeLoansController, type: :request do
  it 'should return valid calculation' do
    post '/home_loans/calculate', params: { amount: 10_000_000, term_in_years: 1, monthly_interest_rate: 10 }

    expect(response.status).to eql 302
    expect(session['flash']['flashes']).to eql({"notice"=>"Amount you have to pay per month is IDR 916,667.00"})
  end

  it 'should return valid calculation' do
    post '/home_loans/calculate', params: { amount: 100_000_000, term_in_years: 4, monthly_interest_rate: 8 }

    expect(response.status).to eql 302
    expect(session['flash']['flashes']).to eql({"notice"=>"Amount you have to pay per month is IDR 2,250,000.00"})
  end

  it 'should return valid calculation' do
    post '/home_loans/calculate', params: { amount: 250_000_000, term_in_years: 4, monthly_interest_rate: 8 }

    expect(response.status).to eql 302
    expect(session['flash']['flashes']).to eql({"notice"=>"Amount you have to pay per month is IDR 5,625,000.00"})
  end

  it 'should return valid calculation' do
    post '/home_loans/calculate', params: { amount: 105_000_000_000, term_in_years: 8, monthly_interest_rate: 8 }

    expect(response.status).to eql 302
    expect(session['flash']['flashes']).to eql({"notice"=>"Amount you have to pay per month is IDR 1,181,250,000.00"})
  end
end