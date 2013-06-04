require 'rails/generators'

module Kent

  # Module with generators
  #
  module Generators

    # Main install initializer
    #
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)

      # Method for copying initializer
      #
      # Here is what it should install:
      #
      # @example You should have in file config/initializers/kent.rb this:
      #
      #   Kent.configure do |config|
      #
      #     # Class for id generation, should respond to 'generate' method.
      #     #
      #     config.id_generator = UUID
      #
      #     # Redis instance.
      #     #
      #     config.redis = Redis.new
      #
      #     # Resque queue.
      #     #
      #     config.resque_queue = :kent_queue
      #
      #     # Faye host.
      #     #
      #     config.faye_host = "localhost"
      #
      #     # Faye port
      #     #
      #     config.faye_port = 9292
      #
      #   end
      #
      def add_initializer
        template "initializer.erb", "config/initializers/kent.rb"
      end

    end
  end
end