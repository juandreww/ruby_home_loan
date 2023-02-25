class SendPinWorker
  include Sidekiq::Worker

  def perform(phone)
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    service_sid = ENV['SERVICE_SID']

    client = Twilio::REST::Client.new(account_sid, auth_token)

    message = client.messages.create(
      body: 'Thank you for signing up !',
      messaging_service_sid: service_sid,
      to: phone
    )

    puts message.sid
  end
end