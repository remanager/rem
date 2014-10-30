describe Realestate do
  context 'validates' do
    it 'name' do
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).not_to be_nil

      subject.name = 'RealEstateName'
      expect(subject).to be_valid
    end
  end

  describe '#search' do
    let!(:realestate) { FactoryGirl.create(:realestate) }
    let!(:categories) { FactoryGirl.create_list(:category, 2) }
    context 'with valid params' do
      let(:search_params) { { category_ids: [categories.first.id] } }
      it 'should find by category' do
        property1 = FactoryGirl.create(:property, realestate: realestate, categories: Category.all.to_a)
        property2 = FactoryGirl.create(:property, realestate: realestate, categories: [categories.last])
        result = realestate.search(search_params)

        expect(result.size).to eq(1)
        expect(result.first.id).to eq(property1.id)
      end
    end
  end
end
