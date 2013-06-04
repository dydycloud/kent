require File.join(GEM_ROOT, "spec", "support", "loaders", "test_loader.rb")

class DeepLoaderBlank < TestLoader
end

class DeepLoaderWithRenderOverride < TestLoader

  before_render do
    self.class.send(:attr_accessor, :deep_field)
    self.deep_field = :deep_loader
  end

end

class DeepLoaderWithTemplateOverride < TestLoader

  template do
    "template 2"
  end

end

class VeryDeepLoader < DeepLoaderWithRenderOverride

  before_render do
    self.class.send(:attr_accessor, :very_deep_field)
    self.very_deep_field = :very_deep_field
  end

end