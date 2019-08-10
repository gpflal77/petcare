class Hospital < ApplicationRecord
    has_many :like_hospitals
    has_many :users, through: :like_hospitals
end
