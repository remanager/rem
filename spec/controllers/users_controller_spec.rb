require 'rails_helper'

describe Admin::UsersController do
  describe 'new' do

    context 'as admin' do
      it 'renders #admin_new' do
        allow_message_expectations_on_nil
        allow(controller.current_user).to receive(:role).and_return(:admin)
        allow(controller.current_user).to receive(:admin?).and_return(true)

        get :new

        #require 'pry'; binding.pry
        #expect(response).to have_http_status :success
        expect(response).to render_template('admin/user/admin_new')
      end
    end

    context 'as agent' do
      it 'renders #agent_new' do
        allow_message_expectations_on_nil
        allow(controller.current_user).to receive(:role).and_return(:agent)
        allow(controller.current_user).to receive(:admin?).and_return(false)

        get :new

        expect(response).to render_template(:agent_new)
      end
    end
  end
end
