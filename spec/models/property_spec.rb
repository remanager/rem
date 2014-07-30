describe Property do
  let(:town) { create :town }
  let(:user) { create :user, :agent }
  let(:category) { create :category }
  let(:detail) { create :detail }

  context 'validations' do
    describe 'ref' do
      it 'should not have error' do
        subject.ref = 'someref'
        subject.valid?
        expect(subject.errors.messages[:ref]).to be_nil
      end

      it 'should have error' do
        subject.valid?
        expect(subject.errors.messages[:ref]).not_to be_nil
      end
    end

    describe 'town' do
      it 'should not have error' do
        subject.town = town
        subject.valid?
        expect(subject.errors.messages[:town]).to be_nil
      end

      it 'should have error' do
        subject.valid?
        expect(subject.errors.messages[:town]).not_to be_nil
      end
    end

    describe 'user' do
      it 'should not have error' do
        subject.user = user
        subject.valid?
        expect(subject.errors.messages[:user]).to be_nil
      end

      it 'should have error' do
        subject.valid?
        expect(subject.errors.messages[:user]).not_to be_nil
      end
    end
  end

  context 'associations' do
    it { is_expected.to respond_to :town }
    it { is_expected.to respond_to :user }
    it { is_expected.to respond_to :categories }
    it { is_expected.to respond_to :details }

    it 'should add new categories' do
      expect(subject.categories).not_to include(category)
      subject.categories << category
      expect(subject.categories).to include(category)
    end

    it 'should add new details' do
      expect(subject.details).not_to include(detail)
      subject.details << detail
      expect(subject.details).to include(detail)
    end
  end
end
