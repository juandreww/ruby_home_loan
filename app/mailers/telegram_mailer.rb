class TelegramMailer < ApplicationMailer
  def send_group_message(text)
    api_key = TELEGRAM_API_KEY
    chat_id = TELEGRAM_CHAT_ID_GROUP

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
