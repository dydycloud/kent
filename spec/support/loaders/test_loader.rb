class TestLoader < Kent::Loader
  attr_accessor :field

  before_render do
    self.field = :test_loader
  end

  template do
    :template
  end

end