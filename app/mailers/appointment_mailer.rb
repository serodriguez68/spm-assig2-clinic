class AppointmentMailer < ApplicationMailer

  # Sends email about the creation of an appointment to the health care professional
  def create
    @app = params[:appointment]
    @hcp = @app.health_care_professional
    @user = @app.user
    mail(to: @hcp.email, subject: "New appointment for #{@app.start_time}")

  end
end
