describe Admin::TownsController do
  before do
    allow(controller).to receive(:current_user).and_return(create :user, :admin)
  end

  let(:valid_attributes) {
    attributes_for :town
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  describe "GET index" do
    it "assigns all towns as @towns" do
      town = create :town
      get :index, {}
      expect(assigns(:towns)).to eq([town])
    end
  end

  describe "GET show" do
    it "assigns the requested town as @town" do
      town = create :town
      get :show, { id: town.to_param }
      expect(assigns(:town)).to eq(town)
    end
  end

  describe "GET new" do
    it "assigns a new town as @town" do
      get :new, {}
      expect(assigns(:town)).to be_a_new(Town)
    end
  end

  describe "GET edit" do
    it "assigns the requested town as @town" do
      town = create :town
      get :edit, { id: town.to_param }
      expect(assigns(:town)).to eq(town)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Town" do
        expect {
          post :create, { town: valid_attributes }
        }.to change(Town, :count).by(1)
      end

      it "assigns a newly created town as @town" do
        post :create, { town: valid_attributes }
        expect(assigns(:town)).to be_a(Town)
        expect(assigns(:town)).to be_persisted
      end

      it "redirects to the created town" do
        post :create, { town: valid_attributes }
        expect(response).to redirect_to([:admin, Town.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved town as @town" do
        post :create, { town: invalid_attributes }
        expect(assigns(:town)).to be_a_new(Town)
      end

      it "re-renders the 'new' template" do
        post :create, { town: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested town" do
        town = create :town
        put :update, { id: town.to_param, town: { name: 'NewName' } }
        town.reload
        expect(town.name).to eq('NewName')
      end

      it "assigns the requested town as @town" do
        town = create :town
        put :update, { id: town.to_param, town: valid_attributes }
        expect(assigns(:town)).to eq(town)
      end

      it "redirects to the town" do
        town = create :town
        put :update, { id: town.to_param, town: valid_attributes }
        expect(response).to redirect_to([:admin, town])
      end
    end

    describe "with invalid params" do
      it "assigns the town as @town" do
        town = create :town
        put :update, { id: town.to_param, town: invalid_attributes }
        expect(assigns(:town)).to eq(town)
      end

      it "re-renders the 'edit' template" do
        town = create :town
        put :update, { id: town.to_param, town: invalid_attributes }
        expect(response).to render_template(:edit )
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested town" do
      town = create :town
      expect {
        delete :destroy, { id: town.to_param }
      }.to change(Town, :count).by(-1)
    end

    it "redirects to the towns list" do
      town = create :town
      delete :destroy, { id: town.to_param }
      expect(response).to redirect_to(admin_towns_path)
    end
  end
end
