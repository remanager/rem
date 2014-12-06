describe Admin::RealestatesController do

  before do
    allow(controller).to receive(:current_user).and_return(create :user, :admin)
  end
  let(:valid_attributes) {
    attributes_for(:realestate).merge({user_id: 1})
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  describe "GET index" do
    it "assigns all realestates as @realestates" do
      realestate = create :realestate
      get :index, {}
      expect(assigns(:realestates)).to eq([realestate])
    end
  end

  describe "GET show" do
    it "assigns the requested realestate as @realestate" do
      realestate = create :realestate
      get :show, {id: realestate.to_param}
      expect(assigns(:realestate)).to eq(realestate)
    end
  end

  describe "GET new" do
    it "assigns a new realestate as @realestate" do
      get :new, {}
      expect(assigns(:realestate)).to be_a_new(Realestate)
    end
  end

  describe "GET edit" do
    it "assigns the requested realestate as @realestate" do
      realestate = create :realestate
      get :edit, {id: realestate.to_param}
      expect(assigns(:realestate)).to eq(realestate)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Realestate" do
        expect {
          post :create, {realestate: valid_attributes}
        }.to change(Realestate, :count).by(1)
      end

      it "assigns a newly created realestate as @realestate" do
        post :create, {realestate: valid_attributes}
        expect(assigns(:realestate)).to be_a(Realestate)
        expect(assigns(:realestate)).to be_persisted
      end

      it "redirects to the dashboard" do
        post :create, {realestate: valid_attributes}
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved realestate as @realestate" do
        post :create, {realestate: invalid_attributes}
        expect(assigns(:realestate)).to be_a_new(Realestate)
      end

      it "re-renders the 'new' template" do
        post :create, {realestate: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested realestate" do
        realestate = create :realestate
        put :update, {id: realestate.to_param, realestate: { name: 'NewRealEstateName' } }
        realestate.reload
        expect(realestate.name).to eq('NewRealEstateName')
      end

      it "assigns the requested realestate as @realestate" do
        realestate = create :realestate
        put :update, {id: realestate.to_param, realestate: valid_attributes}
        expect(assigns(:realestate)).to eq(realestate)
      end

      it "redirects to the dashboard" do
        realestate = create :realestate
        put :update, {id: realestate.to_param, realestate: valid_attributes}
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    describe "with invalid params" do
      it "assigns the realestate as @realestate" do
        realestate = create :realestate
        put :update, {id: realestate.to_param, realestate: invalid_attributes}
        expect(assigns(:realestate)).to eq(realestate)
      end

      it "re-renders the 'edit' template" do
        realestate = create :realestate
        put :update, {id: realestate.to_param, realestate: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested realestate" do
      realestate = create :realestate
      expect {
        delete :destroy, {id: realestate.to_param}
      }.to change(Realestate, :count).by(-1)
    end

    it "redirects to the realestates list" do
      realestate = create :realestate
      delete :destroy, {id: realestate.to_param}
      expect(response).to redirect_to(admin_realestates_path)
    end
  end

end
