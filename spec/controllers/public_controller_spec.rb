describe PublicController do
  let(:realestate) { FactoryGirl.create(:realestate) }
  let(:category) { FactoryGirl.create(:category) }
  let(:details) { FactoryGirl.create_list(:detail, 3) }

  describe 'POST search' do
    it 'should redirect to the GET route' do
      params = { realestate_id: realestate.id, category_ids: [category.id], detail_ids: details.map(&:id) }
      post :search_dirty, params
      expect(response).to redirect_to(search_path(params))
    end

    it 'should clean the params' do
      post :search_dirty, realestate_id: realestate.id, crappy_stuff: 'discard me'

      expect(response).to redirect_to(search_path(realestate_id: realestate.id))
    end
  end

  describe 'GET search' do
    before { FactoryGirl.create_list(:property, 3, realestate: realestate, categories: [category]) }

    context 'when it has 1 result' do
      it 'should redirect to the property' do
        property = FactoryGirl.create(:property, realestate: realestate, ref: 'im_unique')

        get :search, realestate_id: realestate.id, ref: 'im_unique'

        expect(response).to redirect_to(property_path(realestate_id: realestate.id, id: property.id))
      end
    end

    context 'when it has >1 results' do
      it 'should render show view' do
        get :search, realestate_id: realestate.id, category_ids: [category]

        expect(response).to render_template(:show)
      end
    end

    context 'when it has no results' do
      xit 'should render show view' do
        town = FactoryGirl.create(:town)
        get :search, realestate_id: realestate.id, town_id: town.id

        expect(assigns(@properties).size).to eq(0)
        expect(response).to render_template(:show)
      end
    end
  end
end
