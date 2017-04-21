class InformationMailer < ApplicationMailer
  def funkis_confirmation(application)
    @user = application.user
    @application = application

    mail(to: @user.email, subject: 'SOF17: Anmäld till funkis-pass')
  end
end
