class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.booking_confirmation.subject
  #
  
  def booking_confirmation(booking)
    @booking = booking

    mail to: "#{@booking.user.email}",subject: "Your booking has been confirmed & waiting for confirmation"
  end
def welcome_message(user)

    @user = user

    mail to: "#{user.email}" , subject: "Created Account Succcessfully"
  end
end
