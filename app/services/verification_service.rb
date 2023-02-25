class VerificationService
  attr_reader :name, :phone, :otp
  private :name, :phone, :otp

  def initialize(name, phone, otp)
    @name = name
    @phone = phone
    @otp = otp
  end

  def send_otp_code
    SendPinWorker.perform_async(name, phone, otp)

    'An activation code would be sent to your phone number!'
  end
end