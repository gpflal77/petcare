class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :uesr_id
      t.string :name
      t.string :kind
      t.string :breedW
      t.string :gender
      t.string :birth_date
      t.integer :age
      t.integer :weight
      t.date :reg_date
      t.string :reg_id
      t.date :modi_date
      t.string :modi_id
      t.timestamps
    end
  end
end
