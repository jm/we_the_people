require 'spec_helper'

describe WeThePeople do
  it "can set the api_key" do
    WeThePeople.api_key = '123'
  end
end