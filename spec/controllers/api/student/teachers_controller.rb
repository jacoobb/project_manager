require 'spec_helper'

describe Api::Student::TeachersController do
  describe '#get index' do

    let!(:teacher1) { FactoryGirl.create :teacher}
    let!(:teacher2) { FactoryGirl.create :teacher}
    before { get :index, format: :json }

    it '200' do 
      response.code.should eq '200' 
    end

    it 'teachers count' do
      JSON.parse(response.body).size.should eq 2
    end

    it 'return teacher1' do
      JSON.parse(response.body).first["email"].should eq teacher1.email
    end

    it 'return teacher2' do
      JSON.parse(response.body).last["email"].should eq teacher2.email
    end
    
  end
end