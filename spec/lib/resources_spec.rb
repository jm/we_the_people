require 'spec_helper'

describe WeThePeople::Resource, "WeThePeople Generic Resources" do

  def get_constant(resource)
    "WeThePeople::Resources::#{resource.camelcase}".constantize
  end

  %w{issue location petition response signature user}.each do |resource|

    it "exists in the WeThePeople::Resource namespace" do
      defined?(get_constant(resource)).should be_true
    end

    it "can be initialized" do
      resource_instance = get_constant(resource).new({})
      resource_instance.should_not be_nil
    end

  end

  %w{petition user}.each do |resource|

    it "can build the correct fully qualified URL" do
      get_constant(resource).build_fully_qualified_url.should
      eq "http://petitions.whitehouse.gov/api/v1/#{resource.pluralize}.json"
    end

    it "generates the correct resource url" do
      get_constant(resource).path.should eq resource.pluralize
    end

  end

end