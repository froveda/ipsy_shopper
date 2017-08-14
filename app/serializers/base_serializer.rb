# frozen_string_literal: true

# Base serializer class with method in common for all the serializers
class BaseSerializer < ActiveModel::Serializer
  def id
    object.id.to_s
  end
end
