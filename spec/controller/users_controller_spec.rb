require 'rails_helper'

RSpec.describe UsersController, type: :request do
  it 'should send otp code to user phone number' do
    user = build(:user)
    post '/'
  end
end