class AddConsultationFeeToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :consultation_fee, :decimal, precision: 5, scale: 2
  end
end
