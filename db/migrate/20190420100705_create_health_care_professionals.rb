class CreateHealthCareProfessionals < ActiveRecord::Migration[5.2]
  def change
    create_table :health_care_professionals do |t|
      t.references :specialty, foreign_key: true
      t.string :name
      t.string :email
      t.decimal :consultation_fee, precision: 5, scale: 2
      t.datetime :resigned_at

      t.timestamps
    end
  end
end
