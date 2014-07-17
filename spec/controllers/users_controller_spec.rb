require 'rails_helper'

describe UsersController do
  describe 'new' do
    context 'as admin' do
      it 'renders #admin_new' do
        allow(controller.current_user).to receive(:role).and_return(ROLES[:admin])

        get :new

        expect(response).to render_template(:admin_new)
      end
    end

    context 'as agent' do
      it 'renders #agent_new' do
        allow(controller.current_user).to receive(:role).and_return(ROLES[:agent])

        get :new

        expect(response).to render_template(:agent_new)
      end
    end

    context 'as owner' do
      # authentication does that, not to test here
      xit 'redirects to root' do
        allow(controller.current_user).to receive(:role).and_return(ROLES[:owner])

        get :new

        expect(response).to rendirect_to root_path
      end
    end
  end
end
