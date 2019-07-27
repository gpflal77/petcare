json.extract! pet, :id, :user_id, :name, :kind, :breed, :gender, :birth_date, :age, :weight, :reg_date, :reg_id, :modi_date, :modi_id, :created_at, :updated_at
json.url pet_url(pet, format: :json)
