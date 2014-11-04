# spec/controllers/password_resets_controller.rb

describe PasswordResetsController do
  describe 'GET #new' do
    it 'renders new' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'email doesnt exist' do
      it 'renders the page with error' do
        get :create, { email: 'nobody@example.com' }

        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Email not registered.')
      end
    end

    context 'email exists' do
      it 'rendirects to login_path' do
        user = create :user

        get :create, { email: user.email }

        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq('Email sent with password reset instructions.')
      end
    end
  end

  describe 'GET #edit' do
    context 'password_reset_token not found' do
      it 'redirects to login_path' do
        get :edit, id: 'invalid_token'

        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('Invalid token.')
      end
    end
    context 'password_reset_token found' do
      it 'renders update page' do
        user = create :user, { password_reset_token: 'some_token' }

        get :edit, id: user.password_reset_token

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST #update' do
    context 'password_reset_token has expired' do
      it 'rendirects to new_password_reset_path' do
        user = create :user, { password_reset_token: 'some_token', password_reset_sent_at: 2.hour.ago }

        get :update, { id: user.password_reset_token }

        expect(response).to redirect_to(new_password_reset_path)
        expect(flash[:alert]).to eq('Password reset has expired.')
      end
    end

    context 'password is changed' do
      it 'sets the new password' do
        user = create :user, { password_reset_token: 'some_token', password_reset_sent_at: Time.zone.now }

        get :update, { id: user.password_reset_token, user: { password: 'newpass', password_confirmation: 'newpass'} }

        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq('Password has been changed!')
      end
    end
  end
end
