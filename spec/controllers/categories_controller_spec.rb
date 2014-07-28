describe Admin::CategoriesController do
  before do
    allow(controller).to receive(:current_user).and_return(create :user, :admin)
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      category = create :category
      get :index, {}
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category = create :category
      get :show, {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {}
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      category = create :category
      get :edit, {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, { category: attributes_for(:category) }
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, { category: attributes_for(:category) }
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the created category" do
        post :create, { category: attributes_for(:category) }
        expect(response).to redirect_to([:admin, Category.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        post :create, category: { name: '' }
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        post :create, category: { name: '' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested category" do
        category = create :category
        put :update, { id: category.to_param, category: { name: 'NewCategoryName' } }
        category.reload
        expect(category.name).to eq('NewCategoryName')
      end

      it "assigns the requested category as @category" do
        category = create :category
        put :update, {id: category.to_param, category: attributes_for(:category)}
        expect(assigns(:category)).to eq(category)
      end

      it "redirects to the category" do
        category = create :category
        put :update, {id: category.to_param, category: attributes_for(:category)}
        expect(response).to redirect_to([:admin, category])
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        category = create :category
        allow(category).to receive(:valid?).and_return(false)
        put :update, { id: category.to_param, category: attributes_for(:category) }
        expect(assigns(:category)).to eq(category)
      end

      it "re-renders the 'edit' template" do
        category = create :category
        put :update, { id: category.to_param, category: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = create :category
      expect {
        delete :destroy, {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = create :category
      delete :destroy, { id: category.id }
      expect(response).to redirect_to(admin_categories_path)
    end
  end

end
