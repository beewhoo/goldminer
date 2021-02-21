class Contact < ApplicationRecord
  #relationships
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  #callbacks
  validates :email, uniqueness: true
  before_save :find_or_create_tag

  accepts_nested_attributes_for :tags, allow_destroy: true


  private

  def find_or_create_tag
    _tags = []
    tags.map do |tag|
      if tag.id.nil?
        _tags << Tag.find_or_create_by(name: tag.name.underscore)
      end
    end
    self.tags = _tags 
  end

end
