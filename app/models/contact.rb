class Contact < ApplicationRecord
  validates :email, uniqueness: true
end
