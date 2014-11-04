describe Category do
  context 'validations' do
    it 'has a name' do
      subject.name = 'CategoryName'
      expect(subject).to be_valid
    end

    it 'has an error validating name' do
      expect(subject).not_to be_valid
      expect(subject.errors.any?).to eq(true)
      expect(subject.errors.messages[:name]).not_to be_nil
    end
  end
end
