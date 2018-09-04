# frozen_string_literal: true

#json.cities_required(@province.cities_required) if @province
json.cities(@cities) { |city| json.(city, *city_attributes) }
if @cities.respond_to?(:total_pages)
  json.partial! 'spree/api/shared/pagination', pagination: @cities
end
