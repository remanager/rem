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
        FactoryGirl.create(:property, realestate: realestate, categories: [categories.last])
        result = realestate.search(category_ids: [categories.first.id])

        expect(result.size).to eq(1)
        expect(result.first.id).to eq(property1.id)
      end

      it 'should find by details' do
        property1 = FactoryGirl.create(:property, realestate: realestate, details: details)
        FactoryGirl.create(:property, realestate: realestate, details: [details.last])
        result1 = realestate.search(detail_ids: [details.last.id])
        result2 = realestate.search(detail_ids: [details.first.id, details.last.id])

        expect(result1.to_a.size).to eq(2)
        expect(result2.to_a.size).to eq(1)
        expect(result2.first.id).to eq(property1.id)
      end

      it 'should find by category & details' do
        property1 = FactoryGirl.create(:property, realestate: realestate,
                                       categories: [categories.first], details: details)
        FactoryGirl.create(:property, realestate: realestate, details: [details.last])
        result1 = realestate.search(category_ids: [categories.first.id], detail_ids: [details.last.id])
        result2 = realestate.search(category_ids: [categories.last.id],
                                    detail_ids: [details.first.id, details.last.id])

        expect(result1.to_a.size).to eq(1)
        expect(result1.first.id).to eq(property1.id)
        expect(result2.to_a.size).to eq(0)
      end

      it 'should return a property found by ref' do
        property1 = FactoryGirl.create(:property, realestate: realestate)
        FactoryGirl.create_list(:property, 2, realestate: realestate)

        expect(realestate.search(ref: property1.ref).id).to eq(property1.id)
      end

      it 'should find by town' do
        town = FactoryGirl.create(:town)
        property = FactoryGirl.create(:property, realestate: realestate, town: town)
        FactoryGirl.create(:property, realestate: realestate)
        result = realestate.search(town_id: town.id)

        expect(result.size).to eq(1)
        expect(result.first.id).to eq(property.id)
      end
    end
  end
end
