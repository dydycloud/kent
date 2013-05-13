require 'spec_helper'

describe Kent::AsyncSender do

  let(:worker) { described_class }
  let(:loader) { RealLoader }
  let(:loader_instance) { stub(:loaderInstance) }
  let(:generated_id) { stub(:generatedId) }

  before do
    Kent.configure { |c| c.faye_host = "localhost"; c.faye_port = 80; }
  end

  it "should take jobs from configured queue" do
    worker.queue.should eq :kent_sender
  end

  it "should render template" do
    loader_instance.should_receive(:render_template).with(no_args)
    loader.stub(:new).and_return loader_instance
    worker.template(loader)
  end

  it "should use Kent::Faye as sender" do
    worker.sender.should be_instance_of Kent::Faye
  end

  it "should send it to Faye server" do
    worker.stub(:template => :template, :sender => stub(:Sender))
    worker.sender.should_receive(:publish).with("/#{generated_id}", :template)
    worker.perform(loader, generated_id)
  end
end