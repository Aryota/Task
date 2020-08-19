require "rails_helper"

describe TaskMailer, type: :mailer do
  let(:taxt) { FactoryBot.create(:task, name: "mailer spec", description: "mail check") }

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == "text/plain; charset=UTF-8" }
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == "text/html; charset=UTF-8" }
    part.body.raw_source
  end

  describe "#creation_email" do
    let(:mail) { TaskMailer.creation_email(task) }

    it "has been created mail" do
      # header
      expect(mail.subject).to eq "task complete mail"
      expect(mail.to).to eq(["offspryota@yahoo.co.jp"])
      expect(maiil.from).to eq(["marimowakame@gmail.com"])

      # text
      expect(text_body).to match("以下のタスクを作成しました")
      expect(text_body).to match("mailer spec")
      expect(text_body).to match("mail check")

      # html
      expect(html_body).to match("以下のタスクを作成しました")
      expect(html_body).to match("mailer spec")
      expect(html_body).to match("mail check")
    end
  end
end
