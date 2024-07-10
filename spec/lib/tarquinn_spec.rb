# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn, type: :controller do
  describe 'redirection' do
    let(:controller) { Tarquinn::DummyController.new }

    context 'when configuration calls for a method that allows redirection' do
      it 'redirects to redirection path given by the method' do
        expect(controller).to receive(:redirect_to).with('/path')
        controller.parse_request
      end
    end

    context 'when redirection skip method returns true' do
      before do
        allow(controller).to receive(:should_skip_redirect?) { true }
      end

      it 'does not redirect to redirection path given by the method' do
        expect(controller).not_to receive(:redirect_to)
        controller.parse_request
      end
    end
  end
end
