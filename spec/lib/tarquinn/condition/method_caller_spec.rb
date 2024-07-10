# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::Condition::MethodCaller do
  let(:dummy_controller) { Tarquinn::DummyController.new }
  let(:controller) { Tarquinn::Controller.new(dummy_controller) }

  context 'when initialized with a single method' do
    let(:method) { :true }
    let(:subject) { described_class.new(method) }

    context 'when method returns true' do
      it do
        expect(subject.check?(controller)).to be_truthy
      end
    end

    context 'when method returns true' do
      let(:method) { :false }

      it do
        expect(subject.check?(controller)).to be_falsey
      end
    end
  end

  context 'when initialized with more methods' do
    let(:methods) { %i[true false] }
    let(:subject) { described_class.new(methods) }

    context 'when one return true and the other false' do
      it do
        expect(subject.check?(controller)).to be_truthy
      end
    end

    context 'when all return true' do
      let(:methods) { %i[true true] }
      it do
        expect(subject.check?(controller)).to be_truthy
      end
    end

    context 'when all return false' do
      let(:methods) { %i[false false] }
      it do
        expect(subject.check?(controller)).to be_falsey
      end
    end
  end
end
