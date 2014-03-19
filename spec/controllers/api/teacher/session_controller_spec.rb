require 'spec_helper'

describe Api::Teacher::SessionController do
  let(:teacher) { FactoryGirl.create :teacher, password: '12qwaszx', password_confirmation: '12qwaszx' }

  describe '#post create' do

    it 'authenticate success' do
      post :create, teacher: { email: teacher.email, password: '12qwaszx' }
      response.status.should eq 201
    end

    it 'return email' do
      post :create, teacher: { email: teacher.email, password: '12qwaszx' }
      JSON.parse(response.body)["email"].should eq teacher.id
    end

    it 'authenticate error' do
      post :create, teacher: { email: teacher.email, password: 'zxasqw12' }
      response.status.should eq 401
    end

  end

  describe '#delete destroy' do
    it 'logout' do
      Api::TeacherController.any_instance.stub(:current_teacher).and_return teacher
      delete :destroy, id: teacher.email
      response.status.should eq 201
    end
  end
end