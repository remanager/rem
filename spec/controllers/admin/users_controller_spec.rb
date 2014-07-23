require 'rails_helper'

describe Admin::UsersController do
  describe 'new' do

    context 'as admin' do
      it 'renders #admin_new' do
        allow(controller).to receive(:current_user).and_return(create :user, :admin)

        get :new

        expect(response).to have_http_status :success
        expect(response).to render_template(:admin_new)
      end
    end

    context 'as agent' do
      it 'renders #agent_new' do
        allow(controller).to receive(:current_user).and_return(create :user, :agent)

        get :new

        expect(response).to render_template(:agent_new)
      end
    end
  end
end
