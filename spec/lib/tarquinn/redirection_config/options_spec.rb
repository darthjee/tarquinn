# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Tarquinn::RedirectionConfig::Options do
  describe '#redirection_options' do
    subject(:redirection_options) { options.redirection_options }

    context 'when domain is not set' do
      subject(:options) { described_class.new }

      it 'returns an empty hash' do
        expect(redirection_options).to eq({})
      end
    end

    context 'when domain is set' do
      subject(:options) { described_class.new(domain: 'example.com') }

      it 'returns allow_other_host: true' do
        expect(redirection_options).to eq({ allow_other_host: true })
      end
    end
  end

  describe '#domain?' do
    subject(:options) { described_class.new(domain: domain_value) }

    context 'when domain is not set' do
      let(:domain_value) { nil }

      it 'returns false' do
        expect(options.domain?).to be false
      end
    end

    context 'when domain is set' do
      let(:domain_value) { 'example.com' }

      it 'returns true' do
        expect(options.domain?).to be true
      end
    end
  end
end
