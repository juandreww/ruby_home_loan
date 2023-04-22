require "rails_helper"

RSpec.describe ProductMailer, type: :mailer do
  describe "product_created" do
    let(:mail) { ProductMailer.product_created }

    it "renders the headers" do
      expect(mail.subject).to eq("Product created")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
