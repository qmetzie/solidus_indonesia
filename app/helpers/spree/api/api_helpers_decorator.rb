module Spree
  module Api
    ApiHelpers.module_eval do
      mattr_reader(:city_attributes)
      class_variable_set(:@@city_attributes, [:id, :name, :state_id])
    end
  end
end
