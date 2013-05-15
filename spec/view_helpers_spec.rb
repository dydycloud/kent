require 'spec_helper'
require 'active_support'
require 'action_view'

describe Kent::ViewHelpers do

  class ViewHelper < ActionView::Base
    include Kent::ViewHelpers
  end

  let(:generated_id) { "generated_id" }

  before do
    Kent.configure do |config|
      config.id_generator = stub(:IdGenrator, :generate => generated_id)
    end
  end

  subject(:view_helper) { ViewHelper.new }

  context "#async_load" do
    it "should return valid piece of js" do
      view_helper.async_load(BlankLoader).should eq "<script id='generated_id' type='text/javascript'>subscribe_to_async_load('generated_id')</script>"
    end

    it "should register async loading" do
      view_helper.should_receive(:register_async_loading).with(BlankLoader, generated_id)
      view_helper.async_load(BlankLoader)
    end
  end

  context "#register_async_loading" do

    let(:custom_worker) { stub(:CustomWorker) }

    it "should move processing to background" do
      Resque.should_receive(:enqueue).with(Kent::AsyncSender, "BlankLoader", generated_id)
      view_helper.async_load(BlankLoader)
    end

    it "should be able to override kent_worker" do
      view_helper.stub(:kent_worker => custom_worker)
      Resque.should_receive(:enqueue).with(custom_worker, "BlankLoader", generated_id)
      view_helper.async_load(BlankLoader)
    end

  end
end