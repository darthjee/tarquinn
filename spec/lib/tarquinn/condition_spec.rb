# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::Condition do
  subject(:condition) { described_class.new }

  let(:controller) { instance_double(Tarquinn::Controller) }

  describe '.method_caller' do
    let(:methods) { %i[method1 method2] }

    it do
      expect(described_class.method_caller(methods))
        .to be_a(Tarquinn::Condition::MethodCaller)
    end

    it do
      expect(described_class.method_caller(methods))
        .to eq(Tarquinn::Condition::MethodCaller.new(methods))
    end
  end

  describe '#check?' do
    it do
      expect { condition.check?(controller) }.to raise_error(NotImplementedError)
    end
  end
end
