module AppointmentsHelper
  def default_appointment_message(app)
    ( app.message || 'You did not leave any message').truncate(35)
  end
end
