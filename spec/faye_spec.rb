require 'spec_helper.rb'

describe Kent::Faye do

  let(:uri) { stub(:uri) }

  before do
    Kent.configure do |config|
      config.faye_host = :faye_host
      config.faye_port = :faye_port
    end
  end

  it "should store host, port and timeout" do
    k = Kent::Faye.new(:host => 1, :port => 2)
    k.host.should eq 1
    k.port.should eq 2
  end

  it "should build uri from host and port" do
    k = Kent::Faye.new(:host => "example.com", :port => "123")
    k.uri.should eq URI.parse("http://example.com:123/faye")
  end

  it "should build messge" do
    k = Kent::Faye.new
    expected = { :channel => "my_channel", :data => "my_message" }
    k.build_message("my_channel", "my_message").should eq expected
  end

  let(:uri) { stub(:URI) }
  let(:json) { stub(:JSON) }
  let(:message) { stub(:Message, :to_json => json) }

  it "should send post request to uri" do
    k = Kent::Faye.new(:host => "example.com", :port => "123")
    k.stub(:uri => uri, :build_message => message)
    expected_params = [uri, {:message => json}]
    Net::HTTP.should_receive(:post_form).with(*expected_params)
    k.publish("/channel", :key => 123)
  end

  it "should take Kent configuration if passed host and port are blank" do
    k = Kent::Faye.new
    k.host.should eq Kent.faye_host
    k.port.should eq Kent.faye_port
  end
end