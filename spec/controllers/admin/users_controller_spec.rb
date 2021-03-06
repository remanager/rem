describe Admin::UsersController do
  describe '#index' do
    context 'with permissions' do
      it 'renders index' do
        allow(controller).to receive(:current_user).and_return(create :user_admin)

        get :index

        expect(response).to render_template(:index)
      end
    end

    context 'without permissions' do
      it 'redirects to dashboard' do
        allow(controller).to receive(:current_user).and_return(create :user)

        get :index

        expect(response).to redirect_to(admin_dashboard_path)
      end
    end
  end

  describe '#new' do
    context 'as admin' do
      it 'renders admin_new' do
        allow(controller).to receive(:current_user).and_return(create :user_admin)

        get :new

        expect(response).to have_http_status :success
        expect(response).to render_template(:new)
      end
    end

    context 'as agent' do
      it 'renders agent_new' do
        allow(controller).to receive(:current_user).and_return(create :user_agent_with_realestate)

        get :new

        expect(response).to render_template(:new)
      end
    end
  end
end
