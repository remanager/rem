describe Admin::DetailsController do
  before do
    allow(controller).to receive(:current_user).and_return(create :user, :admin)
  end

  let(:valid_attributes) {
    attributes_for :detail
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  describe "GET index" do
    it "assigns all details as @details" do
      detail = create :detail
      get :index, {}
      expect(assigns(:details)).to eq([detail])
    end
  end

  describe "GET show" do
    it "assigns the requested detail as @detail" do
      detail = create :detail
      get :show, { id: detail.to_param }
      expect(assigns(:detail)).to eq(detail)
    end
  end

  describe "GET new" do
    it "assigns a new detail as @detail" do
      get :new, {}
      expect(assigns(:detail)).to be_a_new(Detail)
    end
  end

  describe "GET edit" do
    it "assigns the requested detail as @detail" do
      detail = create :detail
      get :edit, { id: detail.to_param }
      expect(assigns(:detail)).to eq(detail)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Detail" do
        expect {
          post :create, {detail: valid_attributes }
        }.to change(Detail, :count).by(1)
      end

      it "assigns a newly created detail as @detail" do
        post :create, {detail: valid_attributes }
        expect(assigns(:detail)).to be_a(Detail)
        expect(assigns(:detail)).to be_persisted
      end

      it "redirects to the created detail" do
        post :create, {detail: valid_attributes }
        expect(response).to redirect_to([:admin, Detail.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved detail as @detail" do
        post :create, {detail: invalid_attributes }
        expect(assigns(:detail)).to be_a_new(Detail)
      end

      it "re-renders the 'new' template" do
        post :create, {detail: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested detail" do
        detail = create :detail
        put :update, { id: detail.to_param, detail: { name: 'NewName' } }
        detail.reload
        expect(detail.name).to eq('NewName')
      end

      it "assigns the requested detail as @detail" do
        detail = create :detail
        put :update, { id: detail.to_param, detail: valid_attributes }
        expect(assigns(:detail)).to eq(detail)
      end

      it "redirects to the detail" do
        detail = create :detail
        put :update, { id: detail.to_param, detail: valid_attributes }
        expect(response).to redirect_to([:admin, detail])
      end
    end

    describe "with invalid params" do
      it "assigns the detail as @detail" do
        detail = create :detail
        put :update, { id: detail.to_param, detail: invalid_attributes }
        expect(assigns(:detail)).to eq(detail)
      end

      it "re-renders the 'edit' template" do
        detail = create :detail
        put :update, { id: detail.to_param, detail: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested detail" do
      detail = create :detail
      expect {
        delete :destroy, { id: detail.to_param }
      }.to change(Detail, :count).by(-1)
    end

    it "redirects to the details list" do
      detail = create :detail
      delete :destroy, { id: detail.to_param }
      expect(response).to redirect_to(admin_details_path)
    end
  end
end
