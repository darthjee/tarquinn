# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::Condition do
  subject(:condition) { described_class.new }

  let(:controller) { instance_double(Tarquinn::Controller) }

  describe '#check?' do
    it do
      expect { condition.check?(controller) }.to raise_error(NotImplementedError)
    end
  end
end
