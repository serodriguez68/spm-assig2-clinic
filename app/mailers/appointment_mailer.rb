class AppointmentMailer < ApplicationMailer

  # Sends email about the creation of an appointment to the health care professional
  def create
    @app = params[:appointment]
    @hcp = @app.health_care_professional
    @user = @app.user
    mail(to: @hcp.email,
         subject: "New appointment for #{l @app.start_time, format: :long}")
  end

  # Sends email to HCP to notify about the cancellation
  def  notify_cancellation
    @app = params[:appointment]
    @hcp = @app.health_care_professional
    @user = @app.user
    mail(to: @hcp.email,
         subject: "The appointment on #{l @app.start_time, format: :long} has been cancelled")
  end
end
