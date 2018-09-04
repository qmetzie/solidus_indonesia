module Spree
  State.class_eval do
    has_many :cities, -> { order(:name) }, dependent: :destroy, class_name: "Spree::City"
  end
end
