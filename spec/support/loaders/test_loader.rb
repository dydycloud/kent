class TestLoader < Kent::Loader

  before_render do
    self.class.instance_eval { attr_accessor :field }
    self.field = :test_loader
  end

  template do
    :template
  end

end