require 'spec_helper'

describe "configuration" do

  it "should be able to configure redis" do
    Kent.configure do |config|
      config.redis = 123
    end

    Kent.redis.should eq 123
  end
end