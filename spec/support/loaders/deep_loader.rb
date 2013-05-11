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

class VeryDeepLoader < DeepLoaderWithRenderOverride

  attr_accessor :very_deep_field

  before_render do
    self.very_deep_field = :very_deep_field
  end

end