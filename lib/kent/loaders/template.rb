#
# Module for defining base accessors for storing a path to template
#
module Kent::Loader::Template

  # @private
  #
  def inherited(klass)
    klass.template_path = self.template_path
    super
  end

  attr_accessor :template_path

  # Returns path to template
  #
  # @return [String] path to template
  #
  # @see #template
  #
  def template_path
    @template_path ||= ""
  end

  # Method for setting a path to template
  #
  # @example
  #   template { "path/to/template" }
  #
  # @yield
  # @see #template_path
  #
  def template
    @template_path = yield
  end

end