class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :hospital_id
      t.integer :user_id
      t.integer :pet_id
      t.string :medic_code
      t.string :medic_detail
      t.integer :period
      t.string :heal_yn
      t.integer :cost_id
      t.integer :tot_cost
      t.integer :satis1
      t.integer :satis2
      t.integer :satis3
      t.integer :satis4
      t.string :avg_satis
      t.text :hospital_review
      t.text :heal_review
      t.string :file
      t.string :photo_file
      t.timestamps
    end
  end
end
