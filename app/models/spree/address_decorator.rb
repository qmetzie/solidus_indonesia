module Spree
  Address.class_eval do
    belongs_to :city, class_name: "Spree::City"

    validates :zipcode, numericality: { only_integer: true }
    validates :phone, numericality: { only_integer: true }

    validate :city_validate
    validate :validate_city_matches_state

    # @return [String] a string representation of this city
    def city_text
      city.try(:name) || city_name
    end

    def city_validate
      # ensure associated city belongs to state
      if city.present?
        if city.state == state
          self.city_name = nil # not required as we have a valid city and state combo
        elsif city_name.present?
          self.city = nil
        else
          errors.add(:city, :invalid)
        end
      end

      # ensure city_name belongs to state without cities, or that it matches a predefined city name/abbr
      if city_name.present?
        if state.cities.present?
          cities = state.cities.with_name(city_name)

          if cities.size == 1
            self.city = cities.first
            self.city_name = nil
          else
            errors.add(:city, :invalid)
          end
        end
      end

      # ensure at least one city field is populated
      errors.add :city, :blank if city.blank? && city_name.blank?
    end

    def validate_city_matches_state
      if city && city.state != state
        errors.add(:city, :does_not_match_state)
      end
    end
  end
end
