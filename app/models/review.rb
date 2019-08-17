class Review < ApplicationRecord
    has_one_attached :photo_file
    has_one_attached :file
end
