# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::RequestHandlerBuilder do
  describe '#build' do
    let(:controller) do
      double('controller')
    end

    it do
      expect(subject.build(controller)).to be_a(Tarquinn::RequestHandler)
    end
  end
end
