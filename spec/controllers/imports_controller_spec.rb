require 'spec_helper'

describe ImportsController do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_success
    end

    it 'assigns a new import instance' do
      get :new
      expect(assigns(:import)).to be_new_record
      expect(assigns(:import).class).to eq(Import)
    end
  end
end
