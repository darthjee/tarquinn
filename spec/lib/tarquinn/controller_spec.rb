require 'spec_helper'

describe Tarquinn::Controller do
  let(:controller) { Tarquinn::DummyController.new }
  let(:subject) { described_class.new(controller) }

  describe '#call' do
    it 'redirects a method call to the controller' do
      expect(controller).to receive(:redirect_to)
      subject.call(:redirect_to)
    end
  end

  describe '#params' do
    it 'returns the instance params call' do
      expect(subject.params).to eq(action: 'show')
    end
  end

  describe '#has_method?' do
    context 'when calling for a public method that exists' do
      it do
        expect(subject.has_method?(:parse_request)).to be_truthy
      end
    end

    context 'when calling for a private method that exists' do
      it do
        expect(subject.has_method?(:redirection_path)).to be_truthy
      end
    end

    context 'when calling for a non existing method' do
      it do
        expect(subject.has_method?(:non_existing)).to be_falsey
      end
    end
  end
end
