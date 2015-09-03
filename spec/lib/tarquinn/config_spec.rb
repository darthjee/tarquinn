require 'spec_helper'

describe Tarquinn::Config do
  let(:subject) { described_class.new(:redirect) }

  describe '#add_redirection_rules' do
    context 'when not passing a block' do
      it do
        expect do
          subject.add_redirection_rules(:methods)
        end.to change { subject.redirection_blocks }
      end

      it do
        subject.add_redirection_rules(:methods)
        expect(subject.redirection_blocks.last).to be_a(Tarquinn::ProcRunner::MethodCaller)
      end

      it do
        expect do
          subject.add_redirection_rules(:methods)
        end.not_to change { subject.skip_blocks }
      end
    end

    context 'when passing only a block' do
      it do
        expect do
          subject.add_redirection_rules { true }
        end.to change { subject.redirection_blocks }
      end

      it do
          subject.add_redirection_rules { true }
        expect(subject.redirection_blocks.last).to be_a(Tarquinn::ProcRunner)
      end

      it do
        expect do
          subject.add_redirection_rules { true }
        end.not_to change { subject.skip_blocks }
      end
    end
  end

  describe '#add_skip_rules' do
    context 'when not passing a block' do
      it do
        expect do
          subject.add_skip_rules(:methods)
        end.to change { subject.skip_blocks }
      end

      it do
        expect do
          subject.add_skip_rules(:methods)
        end.not_to change { subject.redirection_blocks }
      end

      it do
        subject.add_skip_rules(:methods)
        expect(subject.skip_blocks.last).to be_a(Tarquinn::ProcRunner::MethodCaller)
      end
    end

    context 'when passing only a block' do
      it do
        expect do
          subject.add_skip_rules { true }
        end.to change { subject.skip_blocks }
      end

      it do
        expect do
          subject.add_skip_rules { true }
        end.not_to change { subject.redirection_blocks }
      end

      it do
        subject.add_skip_rules { true }
        expect(subject.skip_blocks.last).to be_a(Tarquinn::ProcRunner)
      end
    end
  end

  describe '#add_skip_action' do
    it do
      expect do
        subject.add_skip_action(:methods)
      end.to change { subject.skip_blocks }
    end

    it do
      expect do
        subject.add_skip_action(:methods)
      end.not_to change { subject.redirection_blocks }
    end

    it do
      subject.add_skip_action(:methods)
      expect(subject.skip_blocks.last).to be_a(Tarquinn::ProcRunner::ActionChecker)
    end

  end
end
