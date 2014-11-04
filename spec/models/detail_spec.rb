describe Detail do
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
  end

  it 'should be valid' do
    subject.name = 'some_name'
    expect(subject).to be_valid
  end
end
