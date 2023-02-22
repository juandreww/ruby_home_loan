class VerificationService
  attr_reader :phone
  private :phone

  def initialize(phone)
    @phone = phone
  end

  def send_otp_code
    SendPinWorker.perform_async(@phone)

    'An activation code would be sent to your phone number!'
  end
end