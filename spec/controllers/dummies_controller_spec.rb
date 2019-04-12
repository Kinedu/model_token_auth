require 'rails_helper'

RSpec.describe DummiesController do
  context 'model authenticate' do

    let :dummy do
      DummyOne.create
    end

    it { expect(subject.respond_to? :authenticate!).to be true }

    pending '#current_dummy_one'
  end
end