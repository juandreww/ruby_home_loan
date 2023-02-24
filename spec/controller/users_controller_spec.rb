require 'rails_helper'

RSpec.describe UsersController, type: :request do
  it 'should send otp code to user phone number' do
    user = build(:user)
    post '/users/send_otp_code', params: {user: {phone: user.phone} }
    payload = JSON.parse(response.body)

    expect(response.status).to eql 200
    expect(payload['message']).to eql('An activation code would be sent to your phone number!')
    expect(payload['phone']).to eql user.phone.to_s
  end
end