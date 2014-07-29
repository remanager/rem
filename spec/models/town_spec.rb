describe Town do
  context 'validations' do
    describe 'name' do
      it 'should have error' do
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:name]).not_to be_nil
      end

      it 'should not have error' do
        subject.name = 'some_name'
        subject.valid?
        expect(subject.errors.messages[:name]).to be_nil
      end
    end

    describe 'postcode' do
      it 'should have error' do
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:postcode]).not_to be_nil
      end

      it 'should not have error' do
        subject.postcode = '01234'
        subject.valid?
        expect(subject.errors.messages[:postcode]).to be_nil
      end
    end

    it 'should be valid' do
      subject.name = 'some_name'
      subject.postcode = '01234'
      expect(subject).to be_valid
    end
  end
end
