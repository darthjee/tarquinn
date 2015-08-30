require 'spec_helper'

describe Tarquinn::Handler do
  let(:controller) { double('controller') }
  let(:config) { Tarquinn::Config.new(:redirect_method) }
  let(:subject) { described_class.new config, controller }

  describe '#perform_redirect?' do
    context 'when rules allow for redirection' do
      before do
        config.add_redirection_rules { true }
      end

      it do
        expect(subject.perform_redirect?).to be_truthy
      end

      context 'but some grant a skip' do
        before do
          config.add_skip_rules { true }
        end

        it do
          expect(subject.perform_redirect?).to be_falsey
        end
      end
    end

    context 'when rules do not allow for redirection' do
      before do
        config.add_redirection_rules { false }
      end

      it do
        expect(subject.perform_redirect?).to be_falsey
      end

      context 'but some do not grant a skip' do
        before do
          config.add_skip_rules { false }
        end

        it do
          expect(subject.perform_redirect?).to be_falsey
        end
      end
    end
  end
end
