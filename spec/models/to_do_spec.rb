require 'spec_helper'

describe ToDo do
  it "can be instantiated" do
    ToDo.new.should be_an_instance_of ToDo
  end
end
