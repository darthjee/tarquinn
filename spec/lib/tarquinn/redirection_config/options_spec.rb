# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Tarquinn::RedirectionConfig::Options do
  describe '#domain' do
    context 'when domain is not set' do
      subject(:options) { described_class.new }

      it 'returns nil' do
        expect(options.domain).to be_nil
      end
    end

    context 'when domain is set to a string' do
      subject(:options) { described_class.new(domain: 'example.com') }

      it 'returns the configured string' do
        expect(options.domain).to eq('example.com')
      end
    end

    context 'when domain is set to a symbol' do
      subject(:options) { described_class.new(domain: :some_domain_method) }

      it 'returns the configured symbol' do
        expect(options.domain).to eq(:some_domain_method)
      end
    end
  end
end
