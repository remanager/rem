describe SessionsController do
  subject { create :user, :agent }

  describe 'create' do
    it 'authenticates user' do
      post :create, email: subject.email, password: subject.password, remember_me: 1

      expect(flash[:notice]).to eq('Logged in!')
      expect(response).to redirect_to admin_dashboard_path
      expect(cookies[:auth_token]).to eq(subject.auth_token)
    end

    it 'fails authenticating user' do
      post :create, email: subject.email, password: 'wrong_password', remember_me: 0

      expect(flash[:alert]).to eq('Invalid email or password.')
      expect(response).to render_template('new')
      expect(cookies[:auth_token]).to be_nil
    end
  end

  describe 'destroy' do
    it 'removes cookies' do
      cookies[:auth_token] = subject.auth_token

      get :destroy

      expect(flash[:notice]).to eq('Logged out!')
      expect(response).to redirect_to root_path
      expect(cookies[:auth_token]).to be_nil
    end
  end
end
