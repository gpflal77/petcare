class CreateCosts < ActiveRecord::Migration[5.2]
  def change
    create_table :costs do |t|
      t.integer :avg
      t.integer :tot_cnt
      t.integer :c01
      t.integer :c01_cnt
      t.integer :max_c01
      t.integer :min_c01
      t.integer :tot_cnt
      t.integer :c03
      t.integer :c03_cnt
      t.integer :max_c03
      t.integer :min_c03
      t.integer :c04
      t.integer :c04_cnt
      t.integer :max_c04
      t.integer :min_c04
      t.integer :c05
      t.integer :c05_cnt
      t.integer :max_c05
      t.integer :min_c05
      t.integer :c06
      t.integer :c06_cnt
      t.integer :max_c06
      t.integer :min_c06
      t.integer :c99
      t.integer :c99_cnt
      t.integer :max_c99
      t.integer :min_c99
      t.integer :heal_y
      t.integer :heal_n
      t.integer :heal_state     
      t.timestamps
    end
  end
end
