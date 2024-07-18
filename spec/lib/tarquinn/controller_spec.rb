# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::Controller do
  subject(:controller) { described_class.new(rails_controller) }

  let(:rails_controller) { Tarquinn::DummyController.new }

  describe '#call' do
    it 'redirects a method call to the controller' do
      expect(rails_controller).to receive(:redirect_to)
      subject.call(:redirect_to)
    end
  end

  describe '#run' do
    context 'when block does not call any controller method' do
      let(:block) { proc { 12 } }

      it 'returns the value from the block' do
        expect(controller.run(&block)).to eq(12)
      end
    end

    context 'when block references a value outside' do
      let(:block) do
        value = 15
        proc { value }
      end

      it 'returns the value' do
        expect(controller.run(&block)).to eq(15)
      end
    end

    context 'when block references a method in the controller' do
      let(:block) { proc { params } }

      it 'returns the value' do
        expect(controller.run(&block))
          .to eq(ActionController::Parameters.new(action: 'show'))
      end
    end
  end

  describe '#params' do
    it 'returns the instance params call' do
      expect(subject.params).to eq(ActionController::Parameters.new(action: 'show'))
    end
  end

  describe '#method?' do
    context 'when calling for a public method that exists' do
      it do
        expect(subject.method?(:parse_request)).to be_truthy
      end
    end

    context 'when calling for a private method that exists' do
      it do
        expect(subject.method?(:redirection_path)).to be_truthy
      end
    end

    context 'when calling for a non existing method' do
      it do
        expect(subject.method?(:non_existing)).to be_falsey
      end
    end
  end
end
