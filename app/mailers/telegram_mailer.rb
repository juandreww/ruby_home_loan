class TelegramMailer < ApplicationMailer
  def send_group_message
    api_key = TELEGRAM
    chat_id = TELEGRAM_CHAT_ID_GROUP
    text = "Andrew's PC just send you a message at #{(Time.zone.now + 7.hours).strftime(JAKARTA_DDMMYYHHMM)}"

    HTTParty.post("https://api.telegram.org/#{TELEGRAM_API_KEY}/sendMessage",
        headers: {
          'Content-Type' => 'application/json'
        },
        body: {
          chat_id: chat_id,
          text: text
        }.to_json
      )
  end
end
