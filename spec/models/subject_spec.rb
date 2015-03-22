require 'spec_helper'

describe Subject do
  it "can be instantiated" do
    Subject.new.should be_an_instance_of Subject
  end

  let(:subject) { FactoryGirl.create :subject}
  
  it 'subject factory girl' do
    subject.reload
    Subject.last.should eq subject
  end
end
