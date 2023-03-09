require "prawn"

class HomeLoansController < ApplicationController
  skip_before_action :verify_authenticity_token
  rescue_from Exception, with: :amount_exceed_limit
  rescue_from ZeroMonthlyInterestRate, with: :zero_monthly_interest_rate

  def new
  end

  def amount_exceed_limit
    redirect_to '/home_loans/new', notice: "Loan amount exceeded 100 Billion"
  end

  def zero_monthly_interest_rate
    redirect_to '/home_loans/new', notice: "Monthly Interest Rate cannot be zero"
  end

  def calculate
    total_amount = 0

    session[:amount] = calculate_params[:amount]
    session[:term_in_years] = calculate_params[:term_in_years]
    session[:monthly_interest_rate] = calculate_params[:monthly_interest_rate]

    if calculate_params[:amount].to_d > 100_000_000_000
      raise Exception.new "This is an exception"
    end

    total_months = calculate_params[:term_in_years].to_i * 12
    monthly_payable_amount = total_months.zero? ? 0 : calculate_monthly_payable_amount(total_months)
    session[:latest_calculated_monthly_payable_amount] = monthly_payable_amount

    redirect_to '/home_loans/new', notice: "Amount you have to pay per month is #{ActionController::Base.helpers.number_to_currency(monthly_payable_amount.ceil, unit: "IDR ")}"
  end

  def calculate_monthly_payable_amount(total_months)
    monthly_interest_rate = calculate_params[:monthly_interest_rate].to_d / 100
    initial_amount = calculate_params[:amount].to_d

    monthly_payable_amount = initial_amount / total_months
    monthly_payable_amount_after_interest = monthly_payable_amount + (monthly_interest_rate * monthly_payable_amount)

    monthly_payable_amount_after_interest
  end

  def page_title
    'Home Loans'
  end

  def reset
    session.delete(:amount)
    session.delete(:term_in_years)
    session.delete(:monthly_interest_rate)

    redirect_to '/home_loans/new'
  end

  def print_pdf
    respond_to do |format|
      format.pdf do
        if session[:monthly_interest_rate].to_d == 0
          raise ZeroMonthlyInterestRate.new "This is an exception"
        end

        send_data(build_pdf.render,
                  filename: 'hello.pdf',
                  type: 'application/pdf')
      end
    end
  end

  private

  def build_pdf
    pdf = Prawn::Document.new

    pdf.text "Beginning Loan Calculation", align: :center
    pdf.move_down 10
    pdf.text "Amount to be borrowed: #{ActionController::Base.helpers.number_to_currency(session[:amount].to_d.ceil, unit: "IDR ")}"
    pdf.text "Term of Loan: #{session[:term_in_years].to_i} years"
    pdf.text "Monthly Interest Rate: #{session[:monthly_interest_rate].to_i}"
    pdf.text ""
    pdf.text "Amount to be paid per month is #{ActionController::Base.helpers.number_to_currency(session[:latest_calculated_monthly_payable_amount].to_d.ceil, unit: "IDR ")}"

    pdf
  end

  def calculate_params
    calculate_params ||= params.permit(:amount, :term_in_years, :monthly_interest_rate)
  end
end
