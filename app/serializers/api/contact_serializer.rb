class Api::ContactSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email

  has_many :tags, serializer: ::Api::TagSerializer
end
