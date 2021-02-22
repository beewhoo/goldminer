class Contact < ApplicationRecord
  include Filterable
  # relationships
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  # callbacks
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, uniqueness: true, length: { minimum: 4, maximum: 254} }
  before_save :find_or_create_tag

  accepts_nested_attributes_for :tags, allow_destroy: true

  scope :search_by_tag, lambda { |tag|
    _name = tag.is_a?(Array) ? tag.map(&:underscore) : tag.underscore

    joins(:tags)
      .where(tags: { name: _name })
  }

  private

  def find_or_create_tag
    _tags = []
    tags.map do |tag|
      _tags << Tag.find_or_create_by(name: tag.name.underscore) if tag.id.nil?
    end
    self.tags = _tags
  end
end
