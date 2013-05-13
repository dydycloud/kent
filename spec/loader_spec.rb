require 'spec_helper'

describe Kent::Loader do
  it "should store params" do
    loader = Kent::Loader.new(:params)
    loader.params.should eq :params
  end

  describe "#configuration" do

    let(:loader) { TestLoader.new }

    it "should be able to configure before render block" do
      loader.run_before_render_hooks
      loader.field.should eq :test_loader
    end

    it "should be able to configure template path" do
      TestLoader.template_path.should eq :template
    end
  end

  context "#default data" do
    it "should return blank proc if it's not configured" do
      BlankLoader.before_render_procs.should eq []
    end

    it "should return empty string if template is not configured" do
      BlankLoader.template_path.should == ""
    end
  end

  context "#deep inheritance" do

    context "DeepLoaderBlank should return data from parent class (it's not configured)" do

      let(:loader) { DeepLoaderBlank.new }

      it "should return template from parent" do
        DeepLoaderBlank.template_path.should eq :template
      end

      it "should call before render block from parent" do
        loader.run_before_render_hooks
        loader.field.should eq :test_loader
      end

    end

    context "DeepLoaderWithRenderOverride" do

      let(:loader) { DeepLoaderWithRenderOverride.new }

      it "should return template from parent" do
        DeepLoaderWithRenderOverride.template_path.should eq :template
      end

      it "should call before render block from parent + its own callback" do
        loader.run_before_render_hooks
        loader.field.should eq :test_loader
        loader.deep_field.should eq :deep_loader
      end
    end

    context "DeepLoaderWithTemplateOverride" do
      it "should return its own template path" do
        DeepLoaderWithTemplateOverride.template_path.should eq "template 2"
      end
    end

    context "VeryDeepLoader" do

      let(:loader) { VeryDeepLoader.new }

      it "should run callbacks of all ancestors" do
        loader.run_before_render_hooks
        loader.field.should eq :test_loader
        loader.deep_field.should eq :deep_loader
        loader.very_deep_field.should eq :very_deep_field
      end
    end

  end

  context "#render" do

    let(:loader) { RealLoader.new }

    it "should render template" do
      loader.rendering_controller.append_view_path File.join(GEM_ROOT, "spec", "support", "templates")
      loader.render_template.should eq "<div>\n  a = b\n</div>"
    end
  end

end