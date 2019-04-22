class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :health_care_professional, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :start_time
      t.text :message

      t.timestamps
    end
  end
end
