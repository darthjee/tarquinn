# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::Condition::ProcRunner do
  let(:controller) { double }
  let(:value) { true }
  let(:subject) { described_class.new { value } }

  describe '#check?' do
    context 'when block evaluates into true' do
      it do
        expect(subject.check?(controller)).to be_truthy
      end
    end

    context 'when block evaluates into false' do
      let(:value) { false }
      it do
        expect(subject.check?(controller)).to be_falsey
      end
    end
  end
end
