require 'spec_helper'

describe Tarquinn::Config do
  let(:subject) { described_class.new(:redirect) }

  describe '#add_redirection_rules' do
    context 'when not passing a block' do
      it do
        expect do
          subject.add_redirection_rules(:methods)
        end.to change { subject.methods }
      end

      it do
        expect do
          subject.add_redirection_rules(:methods)
        end.not_to change { subject.blocks }
      end
    end

    context 'when not passing only a block' do
      it do
        expect do
          subject.add_redirection_rules { true }
        end.not_to change { subject.methods }
      end

      it do
        expect do
          subject.add_redirection_rules { true }
        end.to change { subject.blocks }
      end
    end
  end
end
