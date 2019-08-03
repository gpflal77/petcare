class CreateCommCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :comm_codes do |t|
      t.string :code_gubn
      t.string :code
      t.string :code_name
      t.string :sta_date
      t.string :end_date
      t.string :del_yn
    end
  end
end
