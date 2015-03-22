require 'spec_helper'

describe Student do
  it "can be instantiated" do
    Student.new.should be_an_instance_of Student
  end

  describe 'password confirmation' do
    let(:student) { Student.new }
    
    it 'return error' do
      student.password = '12qwaszx'
      student.password_confirmation = 'zxasqw12'  
      student.valid?
      student.errors[:password_confirmation].should_not be_empty
    end

    it 'not return error' do
      student.password = '12qwaszx'
      student.password_confirmation = '12qwaszx'  
      student.valid?
      student.errors[:password_confirmation].should be_empty
    end

  end

  describe 'encrypt password before save' do
    let(:student) { FactoryGirl.create :student }
    
    it 'password_salt not empty' do
      student.password_salt.should_not be_empty
    end

    it 'password_salt not empty' do
      student.password_hash.should_not be_empty
    end
  end

  describe 'authenticate' do
    let(:student) { FactoryGirl.create :student, password: '12qwaszx',password_confirmation: '12qwaszx', matricula_number: '88468'}

    it 'return user' do
      student.reload
      Student.authenticate('88468', '12qwaszx').should be_an_instance_of Student
    end

    it 'return user' do
      student.reload
      Student.authenticate('88468', '123456').should be_false
    end

    it 'return user' do
      student.reload
      Student.authenticate('345533', '123456').should be_false
    end

    it 'return user' do
      student.reload
      Student.authenticate('232123', '12qwaszx').should be_false
    end

  end
end