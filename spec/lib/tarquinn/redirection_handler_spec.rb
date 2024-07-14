# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::RedirectionHandler do
  let(:redirection_path) { '/path' }
  let(:controller) { Tarquinn::DummyController.new }
  let(:config) { Tarquinn::Config.new(:redirection_path) }
  let(:subject) do
    described_class.new config, Tarquinn::Controller.new(controller)
  end

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

    context 'when passing a method name for evaluation' do
      context 'when method returns true' do
        before do
          config.add_redirection_rules :true
        end

        it do
          expect(subject.perform_redirect?).to be_truthy
        end

        context 'but some grant a skip' do
          before do
            config.add_skip_rules :true
          end

          it do
            expect(subject.perform_redirect?).to be_falsey
          end
        end
      end

      context 'when method returns false' do
        before do
          config.add_redirection_rules :false
        end

        it do
          expect(subject.perform_redirect?).to be_falsey
        end

        context 'but some do not grant a skip' do
          before do
            config.add_skip_rules :false
          end

          it do
            expect(subject.perform_redirect?).to be_falsey
          end
        end
      end
    end

    describe '#redirect' do
      it 'calls for redirection using controller method' do
        expect(controller).to receive(:redirect_to).with(redirection_path)
        subject.redirect
      end

      context 'when configured with a method that does not exist in the controller' do
        let(:config) { Tarquinn::Config.new('/new_path') }

        it 'calls for redirection using static path' do
          expect(controller).to receive(:redirect_to).with('/new_path')
          subject.redirect
        end
      end
    end
  end
end
