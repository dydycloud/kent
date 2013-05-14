require 'spec_helper'

describe "configuration" do

  it "should be able to configure redis" do
    Kent.configure { |c| c.redis = :redis }
    Kent.redis.should eq :redis
  end

  it "should be able to configure id generator" do
    Kent.configure { |c| c.id_generator = :id_generator }
    Kent.id_generator.should eq :id_generator
  end

  it "set id generate to UUID if it's blank" do
    Kent.configure { |c| c.id_generator = nil }
    Kent.id_generator.should eq UUID
  end

  it "set redis instance if it's blank" do
    Kent.configure { |c| c.redis = nil }
    Kent.redis.should be_instance_of Redis
  end

  it "should be able to configure resque queue" do
    Kent.configure { |c| c.resque_queue = :test_queue }
    Kent.resque_queue.should eq :test_queue
  end

  it "should set :kent_sender as default resque queue" do
    Kent.resque_queue = nil
    Kent.resque_queue.should eq :kent_sender
  end
end