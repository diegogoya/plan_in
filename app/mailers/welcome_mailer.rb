class WelcomeMailer < ApplicationMailer
	  default from: 'from@example.com'
  def event_email(user, event)
        @event = event
        @user = user
        mail(to: @user.email, subject: "Te han invitado a un evento")
  end
  'event_email'
end
