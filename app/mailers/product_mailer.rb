class ProductMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.product_mailer.product_created.subject
  #

  def product_created
    @greeting = "Hi"

    mail(
      from: "looh@support.co.id",
      to: User.first.email,
      cc: User.all.pluck(:email),
      bcc: "secret@support.co.id",
      subject: "New product created"
    )
  end

  def product_updated
    @greeting = "Hi"

    mail(
      from: "looh@support.co.id",
      to: User.first.email,
      cc: User.all.pluck(:email),
      bcc: "secret@support.co.id",
      subject: "New product created"
    )
  end
end
