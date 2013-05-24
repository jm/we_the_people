require 'spec_helper'

describe WeThePeople do
  it "can pull the list of petitions" do
    petitions = WeThePeople::Resources::Petition.all
    petitions.count.should > 0
  end
end