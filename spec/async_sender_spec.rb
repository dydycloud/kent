require 'spec_helper'

describe Kent::AsyncSender do

  let(:worker) { described_class }
  let(:loader) { RealLoader }
  let(:loader_instance) { stub(:loaderInstance) }

  it "should take jobs from configured queue" do
    worker.queue.should eq :kent_sender
  end

  it "should render template" do
    loader_instance.should_receive(:render_template).with(no_args)
    loader.stub(:new).and_return loader_instance
    worker.template(loader)
  end

  it "should send it to Faye server"
end