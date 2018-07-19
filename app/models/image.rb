class Image < ApplicationRecord
  has_one_attached :file
  has_many_attached :formats
end