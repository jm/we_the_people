require 'spec_helper'

describe WeThePeople::Resource, "WeThePeople Generic Resources" do

  %w{issue location petition response signature user}.each do |resource|

    it "Exists in the WeThePeople::Resource namespace" do
      "WeThePeople::Resources::#{resource.camelcase}".constantize
    end

    it "Can be initialized" do
      resource_instance = "WeThePeople::Resources::#{resource.camelcase}".constantize.new({})
      resource_instance.should_not be_nil
    end

  end

end