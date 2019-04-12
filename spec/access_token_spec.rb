require 'rails_helper'

RSpec.describe AccessToken, type: :model do

  let :access_token do
      AccessToken.new entity_type: 'Dummy'
  end

  subject { access_token }

  context 'respond to' do
    it { should respond_to(:token) }
    it { should respond_to(:entity_type) }
    it { should respond_to(:entity_id) }
  end

  context 'associations' do
    it { should belong_to(:entity).optional }
  end

  context 'validations' do
    it { should validate_presence_of(:token) }
    it { should validate_uniqueness_of(:token).scoped_to(:entity_type) }
    it { should be_valid }
  end

  context 'callback' do
    it { is_expected.to callback(:assign_token).after(:initialize).if(:new_record?) }
  end

  describe '#assign_token' do
    pending "add test/spec"
  end
end