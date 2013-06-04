#
# Module for defining base accessors for storing "before render hooks"
#
module Kent::Loader::Hooks

  # @private
  #
  def inherited(klass)
    klass.before_render_procs += before_render_procs
    super
  end

  attr_accessor :before_render_procs

  # Returns before render procs
  #
  # @return [Array<Proc>] Array or "before render procs"
  #
  # @see #before_render
  #
  def before_render_procs
    return [] if self == ::Kent::Loader
    @before_render_procs ||= []
  end

  # Method for setting "before render procs"
  #
  # @see #before_render_procs
  #
  def before_render(&block)
    @before_render_procs << block
  end

end
