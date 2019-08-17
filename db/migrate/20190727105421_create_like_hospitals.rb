class CreateLikeHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :like_hospitals do |t|
     # t.belongs_to :hospital, foreign_key: true
     # t.belongs_to :user, foreign_key: true
      t.integer :user_id
      t.integer :hospital_id
      t.timestamps
    end
  end
end
