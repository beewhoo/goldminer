module Filterable
  extend ActiveSupport::Concern

  module ClassMethods

    def filter(params)
      _results = self.where(nil)
      params.each do |key, value|
        next unless value.present?
        _results = _results.public_send(key, value)
      end
      _results
    end
  end

end
