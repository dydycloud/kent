#
# Main logical class.
# You should inherit from this class
# if you want to make your own loader.
#
# You can configure 2 main values:
#
#   - template
#   - before render procs
#
# Template is a path (from "app/views") to your template
# Before render procs is an Array or procs that will be evaluated before rendering (in context of render object)
#
# Usage (example):
#
#   class MyLoader < Kent::Loader
#
#     before_render do
#       # All instance variables are visible in template
#       @a = 1
#     end
#
#     template do
#       # Template should be in "app/views"
#       "profiles/all"
#     end
#   end
#
#   # app/views/profiles/all.html.erb:
#   <h1>a = <%= @a %></h1>
#
#
#   MyLoader.new.render_template
#     => "<h1>a = 1</h1>"
#

class Kent::Loader

  # Stores request parameters
  #
  # @return [Hash]
  #
  attr_reader :params

  # Bool flag (internal)
  #
  attr_reader :need_to_run_hooks

  # Initialize method
  #
  # @param params [Hash] request parameters
  #
  def initialize(params = {})
    @params = params
    @need_to_run_hooks = true
  end

  # Method for running before render hooks
  #
  def run_before_render_hooks
    return unless @need_to_run_hooks
    self.class.before_render_procs.each do |p|
      rendering_controller.instance_eval(&p)
    end
    @need_to_run_hooks = false
  end

  # Method for template rendering.
  #
  # Can work from any place (even from background)
  #
  def render_template
    run_before_render_hooks
    render :template => template_path, :layout => false
  end

  # Returns path to template.
  #
  # @see Kent::Loaders::Template
  #
  def template_path
    self.class.template_path
  end

  # Method that renders template.
  #
  # @see RenderAnywhere
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

  require 'kent/loaders/hooks'
  require 'kent/loaders/template'
  extend Hooks
  extend Template

end
