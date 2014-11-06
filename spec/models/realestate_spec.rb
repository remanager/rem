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
    let!(:details) { FactoryGirl.create_list(:detail, 3) }

    context 'with valid params' do
      it 'should find by category' do
        property1 = FactoryGirl.create(:property, realestate: realestate, categories: categories)
        property2 = FactoryGirl.create(:property, realestate: realestate, categories: [categories.last])
        result = realestate.search(category_ids: [categories.first.id])

        expect(result.size).to eq(1)
        expect(result.first.id).to eq(property1.id)
      end

      it 'should find by details' do
        property1 = FactoryGirl.create(:property, realestate: realestate, details: details)
        property2 = FactoryGirl.create(:property, realestate: realestate, details: [details.last])
        result1 = realestate.search(detail_ids: [details.last.id])
        result2 = realestate.search(detail_ids: [details.first.id, details.last.id])

        expect(result1.size).to eq(2)
        expect(result2.size).to eq(1)
        expect(result2.first.id).to eq(property2.id)
      end
    end
  end
end
