require 'spec_helper'

describe Api::Student::SessionController do
  let(:student) { FactoryGirl.create :student, password: '12qwaszx', password_confirmation: '12qwaszx' }

  describe '#post create' do

    it 'authenticate success' do
      post :create, student: { matricula_number: student.matricula_number, password: '12qwaszx' }
      response.status.should eq 201
    end

    it 'authenticate error' do
      post :create, student: { matricula_number: student.matricula_number, password: 'zxasqw12' }
      response.status.should eq 401
    end

  end

  describe '#delete destroy' do
    it 'logout' do
      delete :destroy, id: student.matricula_number
      response.status.should eq 201
    end
  end
end