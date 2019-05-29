require 'rails_helper'

RSpec.describe DummiesController do
  describe 'controllers authentication' do
    let :dummy do
      DummyOne.create
    end

    it { expect(subject.respond_to? :authenticate!).to be_truthy }

    context '#authenticate!' do
      before do
        add_authorization_header!(dummy.access_token.token)

        get :index, format: :json
      end

      it { expect(response).to be_successful }

      it { expect(subject.respond_to? :current_dummy_one).to be_truthy }
    end
  end
end