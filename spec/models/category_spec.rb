require 'spec_helper'

describe Category do
  it "can be instantiated" do
    Category.new.should be_an_instance_of Category
  end

  describe 'validate' do
    let(:category) { Category.new }
    before { category.valid? }

    it { category.errors[:name].should_not be_empty }
  end
end
