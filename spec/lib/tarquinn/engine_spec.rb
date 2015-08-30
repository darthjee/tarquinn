require 'spec_helper'

describe Tarquinn::Engine do
  let(:redirection_path) { '/path' }
  let(:redirection_path2) { '/path2' }
  let(:controller) { double('controller', redirect_path: redirection_path) }
  let(:config) { Tarquinn::Config.new(:redirect_path) }
  let(:config2) { Tarquinn::Config.new(:redirect_path2) }
  let(:configs) { { redirect_path: config, redirect_path2: config2 } }
  let(:subject) { described_class.new configs, controller }

  describe '#perform_redirect?' do
    context 'when no redirection should be performed' do
      before do
        config.add_skip_rules { true }
        config2.add_skip_rules { true }
      end

      it do
        expect(subject.perform_redirect?).to be_falsey
      end
    end

    context 'when all redirection is required' do
      before do
        config.add_redirection_rules { true }
        config2.add_redirection_rules { true }
      end

      it do
        expect(subject.perform_redirect?).to be_truthy
      end
    end

    context 'when only one allow for redirection' do
      before do
        config.add_redirection_rules { true }
        config2.add_skip_rules { true }
      end

      it do
        expect(subject.perform_redirect?).to be_truthy
      end
    end
  end
end
