require 'spec_helper'

describe Teacher do
  it "can be instantiated" do
    Teacher.new.should be_an_instance_of Teacher
  end

  let(:teacher) { FactoryGirl.create :teacher}
  
  it 'teacher factory girl' do
    teacher.reload
    Teacher.last.should eq teacher
  end

end
