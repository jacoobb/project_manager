require 'spec_helper'

describe Api::StudentsController do
  let!(:student) { FactoryGirl.create :student }
  let!(:student2) { FactoryGirl.create :student }
  
  before {get :index, format: :json }

  it { response.code.should eq '200'  }
  it { JSON.parse(response.body).count.should eq 2  }
end