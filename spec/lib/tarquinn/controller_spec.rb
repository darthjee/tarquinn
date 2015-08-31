require 'spec_helper'

describe Tarquinn::ParamsHandler do
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
end
