class User < ActiveRecord::Base
  SMTP_SERVER_ERRORS = [
    TimeoutError,
    IOError,
    Net::SMTPUnknownError,
    Net::SMTPServerBusy,
    Net::SMTPAuthenticationError
  ]

  SMTP_CLIENT_ERRORS = [
    Net::SMTPFatalError,
    Net::SMTPSyntaxError
  ]

  def notify_of_action(user, action)
    begin
      Mailer.action_notification(user, action).deliver
    rescue *SMTP_CLIENT_EXCEPTIONS
      flash[:warning] =
        'There was an issue delivering your notification. '\
        'Please check the notification list settings.'
    rescue *SMTP_SERVER_EXCEPTIONS => e
      HoptoadNotifier.notify e
    end
  end
end
