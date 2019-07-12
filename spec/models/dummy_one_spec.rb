require 'rails_helper'

RSpec.describe DummyOne, type: :model do

  let :dummy do
    DummyOne.new
  end

  subject { dummy }

  context 'validations' do
    it { should be_valid }
  end

  context 'callbacks' do
    it { is_expected.to callback(:build_access_token).before(:validation).on(:create) }
  end

  context 'associations' do
    it { should have_one(:access_token).dependent(:destroy) }
  end


  describe '#access_token' do
    context "unpersisted objects or object doesn't have AccessToken associated" do
      it { expect{ dummy.access_token }.to raise_error NoDefinedToken }
    end

    context 'persisted' do
      it do
        dummy.save
        expect( dummy.access_token ).to be_a AccessToken
      end
    end
  end
end