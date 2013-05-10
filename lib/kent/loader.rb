require 'kent/loaders/template'
require 'kent/loaders/hooks'

module Kent
  class Loader
    attr_reader :params

    def initialize(params = {})
      @params = params
    end

    def render
      run_before_render_hooks
    end

    def run_before_render_hooks
      self.class.before_render_procs.each do |p|
        instance_eval(&p)
      end
    end

    class << self
      include Loaders::Template
      include Loaders::Hooks
    end

  end
end