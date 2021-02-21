class Api::ContactSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email

  has_many :tags, serializer: ::Api::TagSerializer

  def full_name
    "#{object.first_name&.capitalize} #{object.last_name&.capitalize}"
  end
end
