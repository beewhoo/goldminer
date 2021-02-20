class Contact < ApplicationRecord
  #relationships
  has_many :taggings
  has_many :tags, through: :taggings
  #callbacks
  validates :email, uniqueness: true
end
