# Main module of gem for asyncronous content loading.
#
module Kent; end

require "rails/all" unless defined? Rails

require "kent/configuration"
Kent.extend Kent::Configuration

require "kent/loader"
require "kent/view_helpers"
require "kent/async_sender"
require "kent/faye"
require "kent/engine"
require "kent/generators/install_generator"
require "uuid" unless defined? UUID
require "redis" unless defined? Redis

ActiveSupport.on_load :action_view do
  ActionView::Base.send(:include, Kent::ViewHelpers)
end

ActiveSupport.on_load(:before_configuration) do
  module ApplicationHelper; end unless defined? ApplicationHelper

  require "render_anywhere"
end