require 'spec_helper'

describe Tarquinn::Condition::ActionChecker do
  let(:dummy_controller) { Tarquinn::DummyController.new }
  let(:controller) { Tarquinn::Controller.new(dummy_controller) }

  context 'when initialized with a single route' do
    let(:route) { :show }
    let(:subject) { described_class.new(route) }

    context 'when receiving a request for the given action' do
      context 'but it was configured with a symbol' do
        it do
          expect(subject.check?(controller)).to be_truthy
        end
      end

      context 'and it was configured with a string' do
        let(:route) { 'show' }

        it do
          expect(subject.check?(controller)).to be_truthy
        end
      end
    end

    context 'when receiving a request for other action action' do
      let(:route) { :view }

      it do
        expect(subject.check?(controller)).to be_falsey
      end
    end
  end

  context 'when initialized with more routes' do
    let(:routes) { [ :show, :view ] }
    let(:subject) { described_class.new(routes) }

    context 'when receiving a request for one of the given action' do
      it do
        expect(subject.check?(controller)).to be_truthy
      end
    end

    context 'when receiving a request for another action' do
      let(:routes) { [ :update, :view ] }
      it do
        expect(subject.check?(controller)).to be_falsey
      end
    end
  end
end
