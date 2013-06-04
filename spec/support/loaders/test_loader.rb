class TestLoader < Kent::Loader

  before_render do
    self.class.send(:attr_accessor, :field)
    self.field = :test_loader
  end

  template do
    :template
  end

end