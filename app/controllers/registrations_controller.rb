class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    if resource.patient?
      home_patient_path
    elsif resource.admin?
      home_admin_path
    end
  end
end