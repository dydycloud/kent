class DeepLoaderBlank < TestLoader
end

class DeepLoaderWithRenderOverride < TestLoader

  attr_accessor :deep_field

  before_render do
    self.deep_field = :deep_loader
  end

end

class DeepLoaderWithTemplateOverride < TestLoader

  template do
    "template 2"
  end

end