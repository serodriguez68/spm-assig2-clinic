module AppointmentsHelper
  def default_appointment_message(app)
    if app.message.present?
      app.message.truncate(35)
    else
      'You did not leave any message'
    end
  end
end
