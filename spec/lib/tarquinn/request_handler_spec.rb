# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::RequestHandler do
  let(:redirection_path) { '/path' }
  let(:redirection_path2) { '/path2' }
  let(:controller) do
    double('controller', redirect_path: redirection_path, redirect_path2: redirection_path2)
  end
  let(:config) { Tarquinn::RedirectionConfig.new(:redirect_path) }
  let(:config2) { Tarquinn::RedirectionConfig.new(:redirect_path2) }
  let(:configs) { { redirect_path: config, redirect_path2: config2 } }
  let(:subject) do
    described_class.new configs, Tarquinn::Controller.new(controller)
  end

  describe '#perform_redirect' do
    context 'when no redirection should be performed' do
      before do
        config.add_skip_rules { true }
        config2.add_skip_rules { true }
      end

      it 'redirects to the first redirection' do
        expect(controller).not_to receive(:redirect_to)
        subject.perform_redirect
      end
    end

    context 'when all redirection are required' do
      before do
        config.add_redirection_rules { true }
        config2.add_redirection_rules { true }
      end

      it do
        expect(controller).to receive(:redirect_to).with(redirection_path)
        subject.perform_redirect
      end
    end

    context 'when only one allow for redirection' do
      context 'when its the first redirection' do
        before do
          config.add_redirection_rules { true }
          config2.add_skip_rules { true }
        end

        it do
          expect(controller).to receive(:redirect_to).with(redirection_path)
          subject.perform_redirect
        end
      end

      context 'when its the second redirection' do
        before do
          config.add_skip_rules { true }
          config2.add_redirection_rules { true }
        end

        it do
          expect(controller).to receive(:redirect_to).with(redirection_path2)
          subject.perform_redirect
        end
      end
    end
  end
end
