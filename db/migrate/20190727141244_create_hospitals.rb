class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :service_id
      t.string :sigu_cd
      t.string :manage_no
      t.string :busi_in_date
      t.string :status_cd
      t.string :status_detail_cd
      t.string :busi_end_date
      t.string :tel_no
      t.string :jibun_addr
      t.string :addr
      t.string :zip_code
      t.string :renew_date
      t.string :loca_x
      t.string :loca_y
      t.string :open_time
      t.string :close_time
      t.string :bigo
      t.timestamps
    end
  end
end
