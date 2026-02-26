# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::RedirectionConfigBuilder do
  let(:configs) { {} }
  let(:redirection) { :my_rule }
  let(:options) { {} }

  describe '.build' do
    subject(:config) do
      described_class.build(configs:, redirection:, options:) do |config|
        config
      end
    end

    context 'when rule does not exist' do
      it do
        expect(config).to be_a(Tarquinn::RedirectionConfig)
      end

      it 'adds the new rule to the collection of rules' do
        expect { config }.to change { configs[redirection] }
          .from(nil).to(an_instance_of(Tarquinn::RedirectionConfig))
      end

      context 'when alter something about the rules' do
        subject(:config) do
          described_class.build(configs:, redirection:, options:) do |config|
            yield_registry << config
            nil
          end
        end

        let(:yield_registry) { [] }

        it 'adds the new redirection rules to the configuration' do
          expect([config]).to eq(yield_registry)
        end

        it 'returns the configuration' do
          expect(config).to be_a(Tarquinn::RedirectionConfig)
        end
      end
    end

    context 'when rule already exists' do
      before do
        configs[redirection] = Tarquinn::RedirectionConfig.new(redirection:)
      end

      it do
        expect { config }.to raise_error(Tarquinn::Exception::RedirectionAlreadyDefined)
      end
    end
  end
end
