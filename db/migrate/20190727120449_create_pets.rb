class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.integer :uesr_id
      t.string :name
      t.string :kind
      t.string :breedW
      t.string :gender
      t.string :birth_date
      t.integer :age
      t.integer :weight
      t.string :photo_file
      t.timestamps
    end
  end
end
