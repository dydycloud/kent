require "rails/all" unless defined? Rails
require "kent/version"
require "kent/configuration"
require "kent/loader"
require "kent/view_helpers"
require "kent/async_sender"
require "kent/view_context"
require "kent/faye"
require "kent/engine"
require "kent/generators/install_generator"

module Kent
  include Configuration
end
