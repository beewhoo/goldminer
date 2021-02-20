class Tag < ApplicationRecord
  #relationships
  has_many :taggings
  has_many :contacts, through: :taggings
end
