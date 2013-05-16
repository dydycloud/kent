require 'spec_helper'
require 'active_support'
require 'action_view'

describe Kent::ViewHelpers do

  class ViewHelper < ActionView::Base
    include Kent::ViewHelpers
  end

  let(:generated_id) { "generated_id" }
  let(:params) { "params" }
  subject(:view_helper) { ViewHelper.new }

  before do
    Kent.configure do |config|
      config.id_generator = stub(:IdGenrator, :generate => generated_id)
    end
    view_helper.stub(:params => params)
  end


  context "#async_load" do
    it "should return valid piece of js" do
      view_helper.async_load(BlankLoader).should eq "<span id='generated_id' class='kent-container' style='display:none;'></span>"
    end

    it "should register async loading" do
      view_helper.should_receive(:register_async_loading).with(BlankLoader, generated_id)
      view_helper.async_load(BlankLoader)
    end
  end

  context "#register_async_loading" do

    let(:custom_worker) { stub(:CustomWorker) }

    it "should move processing to background" do
      Resque.should_receive(:enqueue).with(Kent::AsyncSender, "BlankLoader", generated_id, params)
      view_helper.async_load(BlankLoader)
    end

    it "should be able to override kent_worker" do
      view_helper.stub(:kent_worker => custom_worker)
      Resque.should_receive(:enqueue).with(custom_worker, "BlankLoader", generated_id, params)
      view_helper.async_load(BlankLoader)
    end

  end
end