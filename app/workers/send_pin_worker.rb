class SendPinWorker
  include Sidekiq::Worker

  def perform(phone)
    accounts_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    service_sid = ENV['SERVICE_SID']

    client = Twilio::REST::Client.new(account_sid, auth_token)
    verification_service = client.verify.services(service_sid)

    verification_service
      .verifications
      .create(to: phone, channel: 'sms')
  end
end