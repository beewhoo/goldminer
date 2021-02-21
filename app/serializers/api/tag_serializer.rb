class Api::TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :camel_case_name

  def camel_case_name
    object.name.camelize
  end
end
