# Preview all emails at http://localhost:3000/rails/mailers/volunteer_mailer
class VolunteerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/volunteer_mailer/confirm_email
  def confirm_email
    VolunteerMailer.confirm_email
  end

end
