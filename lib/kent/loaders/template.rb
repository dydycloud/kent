module Loaders
  module Template
    def template
      @template_path = yield
    end

    def template_path
      return "" if self == ::Kent::Loader
      @template_path ||= inherited_template_path
    end

    protected

    def loader_ancestors
      self.ancestors.take_while { |a| a != ::Kent::Loader }.select{ |klass| klass != self }
    end

    def first_ancestor_with_template_path
      loader_ancestors.detect { |klass| klass.template_path }
    end

    def inherited_template_path
      first_ancestor_with_template_path.nil? ? "" : first_ancestor_with_template_path.template_path
    end
  end
end