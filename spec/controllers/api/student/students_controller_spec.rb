require 'spec_helper'

describe Api::Student::StudentsController do
  let(:student) { FactoryGirl.create :student}
  before do
    Api::StudentController.any_instance.stub(:current_student).and_return student
  end

  describe '#get show' do
    it 'Not Found' do
      Api::StudentController.any_instance.stub(:current_student).and_return nil
      get :show, format: :json
      response.status.should eq 401
    end

    describe 'return student' do
      before { get :show, format: :json }
      it { JSON.parse(response.body)["matricula_number"].should eq student.matricula_number }
      it { JSON.parse(response.body)["first_name"].should eq student.first_name }
      it { JSON.parse(response.body)["last_name"].should eq student.last_name }
      it { JSON.parse(response.body)["phone_number"].should eq student.phone_number }
      it { JSON.parse(response.body)["email"].should eq student.email }
      it { JSON.parse(response.body)["pesel"].should eq student.pesel }
    end
  end
end