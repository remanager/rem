describe PublicController do
  describe 'POST search' do
    let(:realestate) { FactoryGirl.create(:realestate) }
    let(:category) { FactoryGirl.create(:category) }
    let(:details) { FactoryGirl.create_list(:detail, 3) }

    it 'should redirect to the GET route' do
      post :search, realestate_id: realestate.id,
        property: { ref: 'discard me', category_ids: [category.id], detail_ids: details.map(&:id) }

      expect(response).to redirect_to(%r"/search\?.*")
    end

    it 'should clean the params'
  end

  describe 'GET search' do
    context 'when it has 1 result' do
      it 'should redirect to the property'
    end

    context 'when it has >1 results' do
      it 'should render show view'
    end
  end
end
