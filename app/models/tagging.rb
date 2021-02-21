class Tagging < ApplicationRecord
  # relationships
  belongs_to :tag
  belongs_to :contact
end
