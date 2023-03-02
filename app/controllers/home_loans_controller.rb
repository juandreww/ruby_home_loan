class HomeLoansController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def calculate
    total_amount = 0

    total_months = calculate_params[:term_in_years].to_i * 12
    @monthly_payable_amount = total_months.zero? ? 0 : calculate_monthly_payable_amount(total_months)

    return @monthly_payable_amount
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
    byebug
    calculate_params ||= params.permit(:authenticity_token, :amount, :term_in_years, :monthly_interest_rate)
  end
end
