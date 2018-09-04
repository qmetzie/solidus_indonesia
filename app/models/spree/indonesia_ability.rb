module Spree
  class IndonesiaAbility
    include CanCan::Ability

    def initialize user
      can :read, Spree::City
    end
  end
end
