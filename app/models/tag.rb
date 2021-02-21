class Tag < ApplicationRecord
  #relationships
  has_many :taggings, dependent: :destroy
  has_many :contacts, through: :taggings
  #callback
  before_save :snake_case_name, if: :new_record_or_name_changed?

  def snake_case_name
    self.name = name.underscore
  end

  private

  def new_record_or_name_changed?
    new_record? || name_changed?
  end

end
