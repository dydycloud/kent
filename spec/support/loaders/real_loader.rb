class RealLoader < Kent::Loader
  before_render { @a = "b" }
  template { "real_template" }
end