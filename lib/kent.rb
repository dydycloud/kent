require 'rails/all' unless defined? Rails
require 'render_anywhere'
require "kent/version"
require "kent/configuration"
require "kent/loader"
require "kent/view_helpers"
require "kent/async_sender"
require "kent/view_context"
require "kent/faye"

module Kent
  include Configuration
end
