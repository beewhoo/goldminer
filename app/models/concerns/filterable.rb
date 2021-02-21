module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params)
      _results = where(nil)
      params.each do |key, value|
        next if value.blank?

        _results = _results.public_send(key, value)
      end
      _results
    end
  end
end
