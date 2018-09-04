module Spree
  class CustomAbility
    include CanCan::Ability

    def initialize user
      can :read, Spree::City
    end
  end
end
