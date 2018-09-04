# frozen_string_literal: true

module Spree
  module Api
    class CitiesController < Spree::Api::BaseController
      skip_before_action :authenticate_user

      def index
        @cities = scope.ransack(params[:q]).result.
                    includes(:state).order('name ASC')

        if params[:page] || params[:per_page]
          @cities = paginate(@cities)
        end

        respond_with(@cities)
      end

      def show
        @cities = scope.find(params[:id])
        respond_with(@cities)
      end

      private

      def scope
        if params[:state_id]
          @state = Spree::State.accessible_by(current_ability, :read).find(params[:state_id])
          @state.cities.accessible_by(current_ability, :read)
        else
          Spree::City.accessible_by(current_ability, :read)
        end
      end
    end
  end
end
