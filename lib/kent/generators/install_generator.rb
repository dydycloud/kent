require 'rails/generators'

module Kent
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def add_initializer
        template "initializer.erb", "config/initializers/kent.rb"
      end
    end
  end
end