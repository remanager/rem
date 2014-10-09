describe Admin::DashboardController do
  describe "GET 'index'" do
    context 'as admin' do
      before :each do
        allow(controller).to receive(:current_user).and_return(create :user_admin)
      end

      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it 'renders index' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'as agent' do
      before :each do
        allow(controller).to receive(:current_user).and_return(create :user_agent)
      end

      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it 'renders index' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'as owner' do
      before :each do
        allow(controller).to receive(:current_user).and_return(create :user)
      end

      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it 'renders index' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
end
