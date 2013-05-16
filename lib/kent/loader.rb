require 'kent/loaders/template'
require 'kent/loaders/hooks'

# Main logical class
#
# Usage (example):
#
# class MyLoader < Kent::Loader
#   ## DSL for passing data to view context
#   before_render do
#     ## All instance variables will be visible in template
#     @a = 1
#   end
#
#   ## DSL for configuring template for rendering
#   template do
#     "profiles/all"
#   end
# end
#
# app/views/profiles/all.html.erb:
# a = <%= @a %>
#
#
# MyLoader.new.render_template
#   => "a = 1"
#

module Kent
  class Loader
    attr_reader :params
    attr_reader :need_to_run_hooks

    def initialize(params = {})
      @params = params
      @need_to_run_hooks = true
    end

    # Method that runs before_render hooks
    #
    def run_before_render_hooks
      return unless @need_to_run_hooks
      self.class.before_render_procs.each do |p|
        rendering_controller.instance_eval(&p)
      end
      @need_to_run_hooks = false
    end

    # Method for template rendering.
    # Can work from any place.
    #
    def render_template
      run_before_render_hooks
      render :template => template_path, :layout => false
    end

    # Returns path to template.
    #
    def template_path
      self.class.template_path
    end

    # Method that renders template.
    #
    def render(*args)
      rendering_controller.render_to_string(*args)
    end

    # Returns controller that will render template.
    #
    def rendering_controller
      @rendering_controller ||= RenderAnywhere::RenderingController.new.tap do |r|
        (class << r; self; end).send(:attr_accessor, :params)
        r.params = @params.symbolize_keys
      end
    end

    class << self
      include Loaders::Template
      include Loaders::Hooks
    end

  end
end

ActiveSupport.on_load(:before_configuration) do
  unless defined? ApplicationHelper
    module ApplicationHelper
    end
  end
  require "render_anywhere"
end