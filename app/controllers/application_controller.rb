class ApplicationController < ActionController::Base
  require "securerandom"

  ActionController::Parameters.action_on_unpermitted_parameters = false

  class ZeroMonthlyInterestRate < StandardError; end
end
