class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: [:my, :all]

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
      redirect_to my_appointments_path, notice: "Your appointment has been created"
    else
      render :new
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    authorize @appointment
    AppointmentMailer.with(appointment: @appointment).notify_cancellation.deliver_later
    @appointment.destroy
    redirect_to my_appointments_path, notice: "Your appointment has been cancelled"
  end

  def my
    @appointments = policy_scope(Appointment)
                      .includes({health_care_professional: [:specialty], user: nil})
                      .order(start_time: :desc)
                      .page(params[:page])
    authorize(@appointments)
  end

  def all
    authorize(Appointment)
    @appointments = policy_scope(Appointment)
                      .includes({health_care_professional: [:specialty], user: nil})
                      .joins(:health_care_professional)
                      .order('start_time DESC, health_care_professionals.name ASC')
                      .page(params[:page])

    @today_tom_apps = policy_scope(Appointment)
                      .includes({health_care_professional: [:specialty], user: nil})
                      .between_dates(Date.today, Date.tomorrow)
                      .joins(:health_care_professional)
                      .order('start_time ASC, health_care_professionals.name ASC')
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
