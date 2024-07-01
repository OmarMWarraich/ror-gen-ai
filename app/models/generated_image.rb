class GeneratedImage < ApplicationRecord
  belongs_to :user
  has_one_attached :sketch
end
