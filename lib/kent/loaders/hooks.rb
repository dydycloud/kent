module Loaders
  module Hooks

    def inherited(klass)
      klass.before_render_procs += before_render_procs
    end

    attr_accessor :before_render_procs

    def before_render_procs
      return [] if self == ::Kent::Loader
      @before_render_procs ||= []
    end

    def before_render(&block)
      @before_render_procs << block
    end

  end
end