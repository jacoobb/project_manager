require 'spec_helper'

describe Teacher do
  it "can be instantiated" do
    Teacher.new.should be_an_instance_of Teacher
  end
  
  describe 'password confirmation' do
    let(:teacher) { Teacher.new }
    
    it 'return error' do
      teacher.password = '12qwaszx'
      teacher.password_confirmation = 'zxasqw12'  
      teacher.valid?
      teacher.errors[:password_confirmation].should_not be_empty
    end

    it 'not return error' do
      teacher.password = '12qwaszx'
      teacher.password_confirmation = '12qwaszx'  
      teacher.valid?
      teacher.errors[:password_confirmation].should be_empty
    end

  end

  describe 'encrypt password before save' do
    let(:teacher) { FactoryGirl.create :teacher }
    
    it 'password_salt not empty' do
      teacher.password_salt.should_not be_empty
    end

    it 'password_salt not empty' do
      teacher.password_hash.should_not be_empty
    end
  end

  describe 'authenticate' do
    let(:teacher) { FactoryGirl.create :teacher, password: '12qwaszx',password_confirmation: '12qwaszx', email: 'true@test.pl'}

    it 'return user' do
      teacher.reload
      Teacher.authenticate('true@test.pl', '12qwaszx').should be_an_instance_of Teacher
    end

    it 'return user' do
      teacher.reload
      Teacher.authenticate('true@test.pl', '123456').should be_false
    end

    it 'return user' do
      teacher.reload
      Teacher.authenticate('false@false.pl', '123456').should be_false
    end

    it 'return user' do
      teacher.reload
      Teacher.authenticate('false@test.pl', '12qwaszx').should be_false
    end

  end

end
