# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::Exception::RedirectionAlreadyDefined do
  subject(:exception) { described_class.new(:redirection_path) }

  describe '#message' do
    it 'returns the correct message' do
      expect(exception.message).to eq('Redirection redirection_path already defined')
    end
  end
end