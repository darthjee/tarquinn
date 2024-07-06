# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::Builder do
  describe '#build' do
    let(:controller) do
      double('controller')
    end

    it do
      expect(subject.build(controller)).to be_a(Tarquinn::Engine)
    end
  end
end
