describe Admin::PropertiesController do
  before do
    allow(controller).to receive(:current_user).and_return(create :user, :admin)
  end

  let(:valid_attributes) {
    attributes_for :property
  }

  let(:invalid_attributes) {
    { ref: '' }
  }

  describe "GET index" do
    it "assigns all properties as @properties" do
      property = create :property
      get :index, {}
      expect(assigns(:properties)).to eq([property])
    end
  end

  describe "GET show" do
    it "assigns the requested property as @property" do
      property = create :property
      get :show, { id: property.to_param }
      expect(assigns(:property)).to eq(property)
    end
  end

  describe "GET new" do
    it "assigns a new property as @property" do
      get :new, {}
      expect(assigns(:property)).to be_a_new(Property)
    end
  end

  describe "GET edit" do
    it "assigns the requested property as @property" do
      property = create :property
      get :edit, { id: property.to_param }
      expect(assigns(:property)).to eq(property)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before :each do
        @town = create :town
        @user = create :user
      end
      it "creates a new Property" do
        expect {
          post :create, { property: valid_attributes.merge({ town_id: @town.id, user_id: @user.id }) }
        }.to change(Property, :count).by(1)
      end

      it "assigns a newly created property as @property" do
        post :create, {property: valid_attributes.merge({ town_id: @town.id, user_id: @user.id }) }
        expect(assigns(:property)).to be_a(Property)
        expect(assigns(:property)).to be_persisted
      end

      it "redirects to the created property" do
        post :create, {property: valid_attributes.merge({ town_id: @town.id, user_id: @user.id }) }
        expect(response).to redirect_to([:admin, Property.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved property as @property" do
        post :create, {property: invalid_attributes }
        expect(assigns(:property)).to be_a_new(Property)
      end

      it "re-renders the 'new' template" do
        post :create, {property: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested property" do
        property = create :property
        put :update, { id: property.to_param, property: { ref: 'NewRef' } }
        property.reload
        expect(property.ref).to eq('NewRef')
      end

      it "assigns the requested property as @property" do
        property = create :property
        put :update, { id: property.to_param, property: valid_attributes }
        expect(assigns(:property)).to eq(property)
      end

      it "redirects to the property" do
        property = create :property
        put :update, { id: property.to_param, property: valid_attributes }
        expect(response).to redirect_to([:admin, property])
      end
    end

    describe "with invalid params" do
      it "assigns the property as @property" do
        property = create :property
        put :update, { id: property.to_param, property: invalid_attributes }
        expect(assigns(:property)).to eq(property)
      end

      it "re-renders the 'edit' template" do
        property = create :property
        put :update, { id: property.to_param, property: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested property" do
      property = create :property
      expect {
        delete :destroy, { id: property.to_param }
      }.to change(Property, :count).by(-1)
    end

    it "redirects to the properties list" do
      property = create :property
      delete :destroy, { id: property.to_param }
      expect(response).to redirect_to(admin_properties_path)
    end
  end

end
