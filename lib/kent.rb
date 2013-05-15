require "rails/all" unless defined? Rails
require "kent/version"
require "kent/configuration"
require "kent/loader"
require "kent/view_helpers"
require "kent/async_sender"
require "kent/faye"
require "kent/engine"
require "kent/generators/install_generator"
require "uuid" unless defined? UUID
require "redis" unless defined? Redis

module Kent
  include Configuration
end
