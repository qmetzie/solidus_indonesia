module SolidusIndonesia
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/solidus_indonesia\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/solidus_indonesia\n"
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/solidus_indonesia\n", before: /\*\//, verbose: true
        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/solidus_indonesia\n", before: /\*\//, verbose: true
      end

      def add_config_and_parameter
        inject_into_file 'config/initializers/spree.rb', %Q[
          # Change Country and Currency to Indonesia
          if Spree::Country.table_exists?
            country = Spree::Country.find_by_name('Indonesia')
            if country.present?
              config.currency = 'IDR'
              config.default_country_id = country.id
            end
          end
        ], after: /config.currency = "USD"/, verbose: true

        append_file 'config/initializers/spree.rb', %Q[
          Spree::PermittedAttributes.address_attributes << :city_id
          Spree::PermittedAttributes.address_attributes << { city: [:id, :name] }
          Spree::Ability.register_ability(Spree::IndonesiaAbility)
        ]
     end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=solidus_indonesia'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]'))
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end

      def include_seed_data
        append_file "db/seeds.rb", <<-SEEDS
        \n
        SolidusIndonesia::Engine.load_seed if defined?(SolidusIndonesia::Engine)
        SEEDS
      end
    end
  end
end
