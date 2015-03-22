require 'spec_helper'

describe Api::Teacher::SessionController do
  let(:teacher) { FactoryGirl.create :teacher, password: '12qwaszx', password_confirmation: '12qwaszx' }

  describe '#post create' do

    it 'authenticate success' do
      post :create, teacher: { email: teacher.email, password: '12qwaszx' }
      response.status.should eq 201
    end

    it 'return id' do
      post :create, teacher: { email: teacher.email, password: '12qwaszx' }
      JSON.parse(response.body)["id"].should eq teacher.id
    end

    it 'return first_name' do
      post :create, teacher: { email: teacher.email, password: '12qwaszx' }
      JSON.parse(response.body)["first_name"].should eq teacher.first_name
    end

    it 'return last_name' do
      post :create, teacher: { email: teacher.email, password: '12qwaszx' }
      JSON.parse(response.body)["last_name"].should eq teacher.last_name
    end

    it 'return academic_title' do
      post :create, teacher: { email: teacher.email, password: '12qwaszx' }
      JSON.parse(response.body)["academic_title"].should eq teacher.academic_title
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