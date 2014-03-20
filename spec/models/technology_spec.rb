require 'spec_helper'

describe Technology do
  it "can be instantiated" do
    Technology.new.should be_an_instance_of Technology
  end

  describe 'validate' do
    let(:technology) { Technology.new }
    before { technology.valid? }

    it { technology.errors[:name].should_not be_empty }
  end
end
