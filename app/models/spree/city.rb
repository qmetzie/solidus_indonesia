module Spree
  class City < Spree::Base
    belongs_to :state, class_name: "Spree::State"
    has_many :addresses, dependent: :nullify

    scope :with_name, ->(name) do
      where(
        arel_table[:name].matches(name)
      )
    end

    def self.cities_group_by_province_id
      city_info = Hash.new { |h, k| h[k] = [] }
      order(:name).each { |city|
        city_info[city.province_id.to_s].push [city.id, city.name]
      }
      city_info
    end

    def <=>(other)
      name <=> other.name
    end

    def to_s
      name
    end
  end
end
