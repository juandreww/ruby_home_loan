class HomeLoansController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def calculate
    total_amount = 0

    total_months = calculate_params[:term_in_years].to_i * 12
    monthly_payable_amount = total_months.zero? ? 0 : calculate_monthly_payable_amount(total_months)

    redirect_to '/home_loans/new', notice: "Amount you have to pay per month is #{ActionController::Base.helpers.number_to_currency(monthly_payable_amount.ceil, unit: "IDR ")}"
  end

  def calculate_monthly_payable_amount(total_months)
    monthly_interest_rate = calculate_params[:monthly_interest_rate].to_d / 100
    initial_amount = calculate_params[:amount].to_d

    initial_amount / total_months + (monthly_interest_rate * initial_amount)
  end

  def page_title
    'Home Loans'
  end

  private

  def calculate_params
    calculate_params ||= params.permit(:amount, :term_in_years, :monthly_interest_rate)
  end
end
