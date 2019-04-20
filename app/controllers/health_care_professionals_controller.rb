class HealthCareProfessionalsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :set_health_care_professional, only: [:edit, :update, :destroy]

  def index
    @health_care_professionals = HealthCareProfessional.all
                                   .includes(:specialty).order(name: :asc)
    authorize @health_care_professionals
  end

  def new
    @health_care_professional = HealthCareProfessional.new
    authorize @health_care_professional
  end

  def create
    @health_care_professional = HealthCareProfessional.new(health_care_professional_params)
    authorize @health_care_professional

    if @health_care_professional.save
      redirect_to health_care_professionals_path, notice: 'Health care professional was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @health_care_professional
  end

  def update
    authorize @health_care_professional
    if @health_care_professional.update(health_care_professional_params)
      redirect_to health_care_professionals_path, notice: 'Health care professional was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @health_care_professional
    @health_care_professional.resign!
    redirect_to health_care_professionals_url, notice: 'Health care professional was successfully marked as resigned.'
  end

  private
    def set_health_care_professional
      @health_care_professional = HealthCareProfessional.find(params[:id])
    end

    def health_care_professional_params
      params.require(:health_care_professional).permit(:specialty_id, :name, :email, :consultation_fee)
    end
end
