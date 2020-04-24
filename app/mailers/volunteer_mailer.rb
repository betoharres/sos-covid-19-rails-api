class VolunteerMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.volunteer_mailer.confirm_email.subject
  #
  def confirm_email
    mail to: @volunteer.email, subject: 'Confirme seu e-mail'
  end
end
