require 'rails_helper'

describe SessionsController do

  subject { create :user, :agent }

  describe 'create' do
    it 'remembers user' do
      post :create, {
        email: subject.email,
        password: 'password',
        remember_me: 1
      }

      expect(flash[:notice]).to eq('Logged in!')
      expect(response).to redirect_to root_path
      expect(cookies[:auth_token]).to eq(subject.auth_token)
    end
  end
end
