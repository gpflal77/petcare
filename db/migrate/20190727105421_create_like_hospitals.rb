class CreateLikeHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :like_hospitals do |t|
      t.bigint :user_id
      t.string :hospital_id
      t.date :reg_date
      t.string :reg_id
      t.date :modi_date
      t.string :modi_id
      t.timestamps
    end
  end
end
