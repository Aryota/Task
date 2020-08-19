class TaskMailer < ApplicationMailer
  default from: "marimowakame@gmail.com"

  def creation_email(task)
    @task = task
    mail(
      subject: "task complete mail",
      to: "offspryota@yahoo.co.jp",
      from: "marimowakame@gmail.com"
    )
  end
end
