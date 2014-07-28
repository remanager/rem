describe Realestate do
  context 'validates' do
    it 'name' do
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).not_to be_nil

      subject.name = 'RealEstateName'
      expect(subject).to be_valid
    end
  end
end
