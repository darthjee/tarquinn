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
end
