require 'spec_helper'

describe Api::Student::StudentsController do
  let(:student) { FactoryGirl.create :student, password: '12qwaszx', password_confirmation: '12qwaszx' }

  describe '#get show' do
    it 'Not Found' do
      get :show, id: '0000000', format: :json
      response.status.should eq 404
    end

    describe 'return student' do
      before { get :show, id: student.matricula_number, format: :json }
      it { JSON.parse(response.body)["matricula_number"].should eq student.matricula_number }
      it { JSON.parse(response.body)["first_name"].should eq student.first_name }
      it { JSON.parse(response.body)["last_name"].should eq student.last_name }
      it { JSON.parse(response.body)["phone_number"].should eq student.phone_number }
      it { JSON.parse(response.body)["email"].should eq student.email }
      it { JSON.parse(response.body)["pesel"].should eq student.pesel }
    end
  end
end