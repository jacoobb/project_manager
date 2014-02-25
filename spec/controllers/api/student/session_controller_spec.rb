require 'spec_helper'

describe Api::Student::SessionController do
  let(:student) { FactoryGirl.create :student, password: '12qwaszx', password_confirmation: '12qwaszx' }

  describe '#post create' do

    it 'authenticate success' do
      post :create, student: { student_id: student.student_id, password: '12qwaszx' }
      response.status.should eq 200
    end

    it 'authenticate error' do
      post :create, student: { student_id: student.student_id, password: 'zxasqw12' }
      response.status.should eq 401
    end

  end

  describe '#delete destroy' do
    it 'logout' do
      delete :destroy, id: student.id
      response.status.should eq 200
    end
  end
end