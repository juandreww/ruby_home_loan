class SendPinWorker
  include Sidekiq::Worker

  def perform(name, phone, otp)
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    service_sid = ENV['SERVICE_SID']
    auth_token = 'failed'
    client = Twilio::REST::Client.new(account_sid, auth_token)

    message = client.messages.create(
      body: "Thank you for signing up #{name}! Here is your OTP code: #{otp}",
      messaging_service_sid: service_sid.to_s,
      to: phone.to_s
    )

    puts message.sid
  end
end