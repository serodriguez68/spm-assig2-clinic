class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def new
    @appointment = Appointment.new(user: current_user)
    authorize @appointment
  end

  def create
    @appointment = current_user.appointments.new(appointment_params)
    authorize @appointment
    if @appointment.save
      # Send email to HCP
      AppointmentMailer.with(appointment: @appointment).create.deliver_later
      redirect_to root_path, notice: "Your appointment has been created"
    else
      render :new
    end
  end

  def destroy
  end

  def my
  end

  def all
  end

  def available_slots_between
    authorize Appointment
    hcp = HealthCareProfessional.find(params[:health_care_professional_id])
    av_slots = Appointment.available_slots_between(hcp, params[:from_date],  params[:to_date])
    respond_to do |format|
      format.json { render json: av_slots }
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:health_care_professional_id, :start_time, :message)
  end

end
