# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::RedirectionHandler do
  let(:redirection_path) { '/path' }
  let(:controller) { Tarquinn::DummyController.new }
  let(:config) { Tarquinn::RedirectionConfig.new(redirection: :redirection_path) }
  let(:subject) do
    described_class.new config, Tarquinn::Controller.new(controller)
  end

  describe '#perform_redirect?' do
    context 'when there are no rules' do
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
      before do
        allow(controller).to receive(:redirect_to)
      end

      it 'calls for redirection using controller method' do
        subject.redirect

        expect(controller).to have_received(:redirect_to).with(redirection_path)
      end

      context 'when configured with a method that does not exist in the controller' do
        let(:config) { Tarquinn::RedirectionConfig.new(redirection: '/new_path') }

        it 'calls for redirection using static path' do
          subject.redirect

          expect(controller).to have_received(:redirect_to).with('/new_path')
        end
      end

      context 'when configured with a domain' do
        let(:config) do
          Tarquinn::RedirectionConfig.new(
            redirection: :redirection_path,
            domain: 'example.com'
          )
        end

        it 'calls for redirection using full path' do
          subject.redirect
        end
      end
    end
  end
end
